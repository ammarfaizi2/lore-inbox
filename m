Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262451AbULOTVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbULOTVm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 14:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbULOTUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 14:20:37 -0500
Received: from denise.shiny.it ([194.20.232.1]:40666 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id S262451AbULOTSg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 14:18:36 -0500
Date: Wed, 15 Dec 2004 20:18:28 +0100 (CET)
From: Giuliano Pochini <pochini@denise.shiny.it>
To: Martin Josefsson <gandalf@wlug.westbo.se>
cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9 NAT problem
In-Reply-To: <1103093585.12078.55.camel@tux.rsn.bth.se>
Message-ID: <Pine.LNX.4.58.0412152006040.26132@denise.shiny.it>
References: <20041213212603.4e698de6.pochini@shiny.it> 
 <Pine.LNX.4.58.0412141025040.23132@tux.rsn.bth.se> 
 <Pine.LNX.4.58.0412142222240.10830@denise.shiny.it> <1103093585.12078.55.camel@tux.rsn.bth.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 15 Dec 2004, Martin Josefsson wrote:

> > > Then try again and then check the kernellog by executing 'dmesg', see if
> > > it complains about bad checksums.
> >
> > Yes :(
>
> :( It seems there are silicon revisions of the apple sungem that produce
> broken checksums. This is what we were worried about, we'll probably
> submit a patch soon that removes the checksum checking,  then it'll
> behave more like < 2.6.9-pre1
>
> In the meantime you can use the patch below that simply comments that
> code out. It's not diffed against 2.6.9 but should apply anyway.

Yes, the patch works fine.
I don't know anything about the network code, but since this is an
hardware problem, IMHO the workaround should go into the sungem driver. I
don't think that ip_conntrack should know anithing about the underlying
hardware. Is it possible to disable hw checksum and to use a sw one ?


--
Giuliano.
