Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264705AbUFTQ7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264705AbUFTQ7I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 12:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264979AbUFTQ7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 12:59:08 -0400
Received: from outmail1.freedom2surf.net ([194.106.33.237]:16845 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S264705AbUFTQ7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 12:59:02 -0400
Date: Sun, 20 Jun 2004 17:57:39 +0100
From: Ian Molton <spyro@f2s.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: James.Bottomley@SteelEye.com, rmk+lkml@arm.linux.org.uk,
       david-b@pacbell.net, linux-kernel@vger.kernel.org, greg@kroah.com,
       tony@atomide.com, jamey.hicks@hp.com, joshua@joshuawise.com
Subject: Re: DMA API issues
Message-Id: <20040620175739.453dae8a.spyro@f2s.com>
In-Reply-To: <20040620162611.GB16038@havoc.gtf.org>
References: <40D359BB.3090106@pacbell.net>
	<1087593282.2135.176.camel@mulgrave>
	<40D36EDE.2080803@pacbell.net>
	<1087600052.2135.197.camel@mulgrave>
	<40D4849B.3070001@pacbell.net>
	<20040619214126.C8063@flint.arm.linux.org.uk>
	<1087681604.2121.96.camel@mulgrave>
	<20040619234933.214b810b.spyro@f2s.com>
	<1087738680.10858.5.camel@mulgrave>
	<20040620165042.393f2756.spyro@f2s.com>
	<20040620162611.GB16038@havoc.gtf.org>
Organization: The Dragon Roost
X-Mailer: Sylpheed version 0.9.12-gtk2-20040617 (GTK+ 2.4.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jun 2004 12:26:11 -0400
Jeff Garzik <jgarzik@pobox.com> wrote:

> 
> Are you purposefully ignoring James?

No, Im failing to see his point which appears to be that if we modify
the DMA API it has to work on all platforms, even if it doesnt work on
them currently.
 
> He is saying the DMA API must be uniform across all platforms.  Your
> proposal 
> 
> 1) breaks this

How? I havent proposed any alteration to the API, just the allocation
system inside it. No drivers would need modification and any platform
not using these allocators would continue to not use them just as it
currently does(nt).

> 2) is unneeded, as many other drivers in this same situation simply
> use ioremap

Except that the OHCI driver (for example) doesnt. it uses the DMA API
(quite rightly) and to use ioremap would mean creating two ohci drivers,
one using the DMA API and one not, which is wasteful and asking for
trouble.

