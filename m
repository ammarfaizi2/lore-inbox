Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbWJPOR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWJPOR5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 10:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbWJPOR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 10:17:56 -0400
Received: from cantor2.suse.de ([195.135.220.15]:49636 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932093AbWJPORz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 10:17:55 -0400
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: dwarf2 stuck Re: lockdep warning in i2c_transfer() with dibx000 DVB - input tree merge plans?
Date: Mon, 16 Oct 2006 16:17:51 +0200
User-Agent: KMail/1.9.3
Cc: "Jiri Kosina" <jikos@jikos.cz>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0610121521390.29022@twin.jikos.cz> <Pine.LNX.4.64.0610161506570.29022@twin.jikos.cz> <4533A5A5.76E4.0078.0@novell.com>
In-Reply-To: <4533A5A5.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610161617.51111.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 October 2006 15:30, Jan Beulich wrote:
> >>> Jiri Kosina <jikos@jikos.cz> 16.10.06 15:08 >>>
> >On Mon, 16 Oct 2006, Jan Beulich wrote:
> >
> >> >Yes, it was compiled using gcc 4.0.2, specifically gcc (GCC) 4.0.2 
> >> >20051125 (Red Hat 4.0.2-8). I can easily reproduce this, what 
> >> >additional information do you need? Or should I just try with newer 
> >> >gcc?
> >> Two possible paths:
> >> a) Try with gcc 4.1.x.
> >
> >Will do probably later today.
> >
> >> b) Send me the offending .o (presumably the one containing 
> >> dibusb_dib3000mc_tuner_attach)
> >
> >You can get it from http://www.jikos.cz/jikos/junk/dibusb-common.o 
> 
> Yes, unfortunately this is another instance of gcc 4.0 generating bad
> unwind data when optimizing and not accumulating outgoing args.
> Andi - did you already create a patch implementing Michael's suggestion?

You mean using -maccumulate-outgoing-args ? Not yet.

I guess we can do it unconditionally for all gccs on both i386
and x86-64, right?

-Andi
