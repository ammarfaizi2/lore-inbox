Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269160AbVBEWU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269160AbVBEWU4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 17:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269225AbVBEWU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 17:20:56 -0500
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:16913 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S269325AbVBEWUs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 17:20:48 -0500
Date: Sat, 5 Feb 2005 23:20:44 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Prarit Bhargava <prarit@sgi.com>
Subject: Re: 2.6.11-rc3-bk1: ide1: failed to initialize IDE interface
Message-Id: <20050205232044.3fa09b12.khali@linux-fr.org>
In-Reply-To: <58cb370e05020513135aaaa64e@mail.gmail.com>
References: <20050204234422.4a9c6fd0.khali@linux-fr.org>
	<58cb370e050204154155cafb20@mail.gmail.com>
	<20050205215535.43ff8cb9.khali@linux-fr.org>
	<58cb370e05020513135aaaa64e@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again Bartlomiej, all,

> > Notice how ide1, which happens to have no device attached, is listed
> > twice. I can reproduce this on my second system as well (i386 too,
> > but otherwise completely different). I guess it doesn't cause any
> > trouble, but looks suboptimal.
> 
> CONFIG_IDE_GENERIC is enabled
> 
> > While we're at it, I also wonder why ide2-ide5 are probed, when
> > neither of my systems has them.
> 
> CONFIG_IDE_GENERIC again

You got it. Disabling CONFIG_IDE_GENERIC let me get rid of these
duplicate/additional probes. Thanks for the hint :)

A real help text attached to this configuration option would certainly
have helped here. And the label misses its leading capital.

> Alan has a patch in -ac to not probe for legacy ports if system
> has PCI but it needs testing and is limited to x86 currently.
> Also it not a full solution as legacy ports logic needs to be
> moved to ide_generic anyway...

Maybe the option should be relabelled from "generic/default IDE chipset
support" to "Non-PCI IDE chipset support" or "Legacy IDE ports support"?
I think it should express the fact that people with modern systems do
not need it, providing this is actually the case - not sure I exactly
understand what it is.

Thanks again,
-- 
Jean Delvare
