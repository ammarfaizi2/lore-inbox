Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262410AbUKZTrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbUKZTrP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 14:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbUKZTqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:46:51 -0500
Received: from zeus.kernel.org ([204.152.189.113]:65474 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262410AbUKZT1O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:27:14 -0500
Date: Fri, 26 Nov 2004 00:37:53 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 37/51: Memory pool support.
Message-ID: <20041125233753.GD2909@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101298427.5805.338.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101298427.5805.338.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This is the memory pool support. It handles all pages freed and
> allocated between the preparation of the image and the completion of
> resuming, except prior to restoring the original kernel at resume time.
> It is designed for speed and to match the fact that suspend2 just about
> exclusively uses order 0 allocations. ("Just about" is why a couple of
> order one and two allocations are also available).

You really should use generic routines. Having your own malloc of
course allows you to be slightly faster; but it also means that code
is much bigger and much uglier.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
