Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265056AbTL1ExR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 23:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265201AbTL1ExR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 23:53:17 -0500
Received: from mail.rdslink.ro ([193.231.236.20]:55014 "EHLO mail.rdslink.ro")
	by vger.kernel.org with ESMTP id S265056AbTL1ExP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 23:53:15 -0500
Date: Sat, 27 Dec 2003 19:44:22 +0200 (EET)
From: caszonyi@rdslink.ro
X-X-Sender: sony@grinch.ro
Reply-To: Calin Szonyi <caszonyi@rdslink.ro>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: linux-kernel@vger.kernel.org, kraxel@bytesex.org
Subject: Re: panic in bttv_risc_planar
In-Reply-To: <2890000.1072499316@[10.10.2.4]>
Message-ID: <Pine.LNX.4.53.0312271940420.573@grinch.ro>
References: <Pine.LNX.4.53.0312262105560.537@grinch.ro> <2850000.1072477728@[10.10.2.4]>
 <Pine.LNX.4.53.0312270235570.7966@grinch.ro> <2890000.1072499316@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Dec 2003, Martin J. Bligh wrote:

> > I'm not familiar with addr2line :-(
> > I was trying this command line(the result is below):
> >  //usr/src/linux-2.6.0 $ addr2line -e ./vmlinux 320
> > ??:0
> >
> > I obtain the same result if i use 0x140 instead of 320 (320 is decimal
> > for 0x140)
>
> "addr2line -e ./vmlinux 0xc0333f60" if I recall correctly
> (the full address, not the offset within the function). Might not need
> the 0x in front.
>

here is what addr2line says
root@grinch -19:39:14- 0 jobs, ver 2.05b.0 4
 //usr/src/linux-2.6.0 $ addr2line -e ./vmlinux c0333f60
/usr/src/linux-2.6.0/drivers/media/video/bttv-risc.c:195

the line  is:

*(rp++)=cpu_to_le32(sg_dma_address(vsg)+voffset);


> But I think maybe Linus already told you what it is ;-)
>

I did the change that Linus suggested and so far so good (no problems)

> M.
>

Thanks to all

Bye
Calin

