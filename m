Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262680AbUKZXyC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262680AbUKZXyC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 18:54:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbUKZTmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:42:23 -0500
Received: from zeus.kernel.org ([204.152.189.113]:63682 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262452AbUKZT1n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:27:43 -0500
Date: Fri, 26 Nov 2004 00:55:27 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 48/51: Swapwriter
Message-ID: <20041125235527.GH2909@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101300479.5805.389.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101300479.5805.389.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This is the swapwriter. It is forms the glue between the highlevel I/O
> routines in io.c and the blockwriter routines in block_io.c. It is
> responsible for allocating storage, translating the requests for pages
> within pagesets into devices and blocks and the like. It is abstracted
> from the block writer because the plan is that we'll eventually have a
> generic file writer (ie not using swapspace, but a simple file,
> possibly

This file alone is bigger than whole swsusp1. That strongly suggests
you have too many layers of abstraction in there. Planning for future
is nice, but not at this cost.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
