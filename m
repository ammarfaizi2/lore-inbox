Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287816AbSA0GtY>; Sun, 27 Jan 2002 01:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287866AbSA0GtK>; Sun, 27 Jan 2002 01:49:10 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:13329 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S287816AbSA0GtA>; Sun, 27 Jan 2002 01:49:00 -0500
Message-ID: <3C53A116.81432588@zip.com.au>
Date: Sat, 26 Jan 2002 22:41:26 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Kevin P. Fleming" <kevin@labsysgrp.com>,
        lkml <linux-kernel@vger.kernel.org>, Grant <gcoady@bendigo.net.au>
Subject: Re: [CFT] Bus mastering support for IDE CDROM audio
In-Reply-To: <3C5119E0.6E5C45B6@zip.com.au> <000701c1a5d5$812ef580$6caaa8c0@kevin> <3C53711B.F8D89811@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> "Kevin P. Fleming" wrote:
> >
> > When reading from the N drive, get lots of "cdrom_pc_intr: read too
> > little data 0 < 2352",
> 
> OK, thanks Kevin (Dan, Kristian, Grant..)
> 
> Seems that some devices simply terminate their DMA in a normal
> manner, report no errors and don't tell us how much data they
> transferred.  From my reading of the ATA spec, they're allowed
> to do that - they only need to report the transfer byte count
> in PIO mode.
> 

There's an updated patch at

	http://www.zip.com.au/~akpm/linux/2.4/2.4.18-pre7/ide-akpm.patch

It now supports multi-frame transfers and should fix the problem
which you observed.

-
