Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261369AbRFFJXP>; Wed, 6 Jun 2001 05:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261454AbRFFJXF>; Wed, 6 Jun 2001 05:23:05 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:18949 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S261369AbRFFJWy>;
	Wed, 6 Jun 2001 05:22:54 -0400
Message-ID: <20010605233816.A512@bug.ucw.cz>
Date: Tue, 5 Jun 2001 23:38:16 +0200
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/devfs/base.c
In-Reply-To: <9fht4j$cce$1@cesium.transmeta.com> <E157AlZ-0006Vi-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <E157AlZ-0006Vi-00@the-village.bc.nu>; from Alan Cox on Tue, Jun 05, 2001 at 07:56:37AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > It's trivial to calculate for DAGs -- directed acyclic graphs.  It's
> > when the "acyclic" constraint is violated that you have problems!
> 
> It may well be that interrupt stacks are a win anyway. If we can get the kernel
> struct out of the stack pages (which would fix some very unpleasant cache
> colour problems) and take the non irq stack down to 4K then irq stacks would
> pay off once you had 25 or so processes on a system

For what it is worth, we are using interrupt stack on x86-64. And it
was not *that* painfull.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
