Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265108AbUHSK41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265108AbUHSK41 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 06:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265139AbUHSK40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 06:56:26 -0400
Received: from math.ut.ee ([193.40.5.125]:49327 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S265108AbUHSK4V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 06:56:21 -0400
Date: Thu, 19 Aug 2004 13:48:45 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Tom Rini <trini@kernel.crashing.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: PPC & 2.6.0-test3: wrong mem size & hang on ifconfig
In-Reply-To: <20040106153737.GJ2415@stop.crashing.org>
Message-ID: <Pine.GSO.4.44.0408191346130.15736-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Jan 06, 2004 at 02:00:20PM +0200, Meelis Roos wrote:
>
> > > > >  			if (getprop(dev_handle, "reg", mem_info,
> > > > > -						sizeof(mem_info) != 8))
> > > > > +						sizeof(mem_info) != 8)) {
> >
> > > 	if ((n = getprop(dev_handle, "reg", mem_info, sizeof(mem_info))
> > > 	!= 8) {
> >
> > I tried it (applied it by hand and fixed parens) and it did not print n
> > and found the right RAM size with todays BK (2.4.24-pre3 by Makefile). I
> > was confused but did read the patch 3 times. Now I see it - one closing
> > parenthesis was in the wrong place. Seems you have fixed it in 2.4 tree
> > already since it's ok in BK.
> >
> > So 2.4 is OK again on my Motorola Powerstack II Pro4000 (prep, no
> > residual, OF present). Thanks! dmesg now tells
> > Memory BAT mapping: BAT2=64Mb, BAT3=0Mb, residual: 0Mb
> > Total memory = 64MB; using 128kB for hash table (at c0240000)
> >
> > 2.6 probably needs the same fix (current 2.6 is not OK).
>
> I hope to get this fixed in 2.6.2 (2.6 lacks the add OF back to PReP
> bits, and the patch is kinda big).

Well, now that my Powerstack II boots 2.6 again, I'm missing the
additional memory - I now have 192M and it only detects 32M :)

Tis is not very urgent though, there are other problems with this
machine before it's production quality with 2.6 - like tulip (and now
maybe also a usb uhci hcd) hanging. I'll try to narrow these down too.

-- 
Meelis Roos (mroos@linux.ee)

