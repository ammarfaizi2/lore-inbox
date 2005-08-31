Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932525AbVHaTOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525AbVHaTOf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 15:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbVHaTOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 15:14:35 -0400
Received: from fmr22.intel.com ([143.183.121.14]:42681 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S932525AbVHaTOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 15:14:35 -0400
Date: Wed, 31 Aug 2005 12:14:23 -0700
From: tony.luck@intel.com
Message-Id: <200508311914.j7VJEN7M009450@agluck-lia64.sc.intel.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Bill Davidsen <davidsen@tmr.com>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, linux-kernel@vger.kernel.org
Subject: Re: KLive: Linux Kernel Live Usage Monitor
In-Reply-To: <20050831014906.GO8515@g5.random>
References: <20050830030959.GC8515@g5.random> <Pine.LNX.4.63.0508300954190.1984@cassini.linux4geeks.de> <20050830082901.GA25438@bitwizard.nl> <Pine.LNX.4.63.0508301044150.1984@cassini.linux4geeks.de> <20050830094058.GA29214@bitwizard.nl> <4314D98E.2030801@tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do you want to try to handle version skew ?  All kernels built
from GIT trees look like 2.6.13 until Linus releases 2.6.14-rc1.
Possible approaches (requiring changes to the kernel Makefile).
1) Use the SHA1 of HEAD to provide a precise identification.
2) Use $(git-rev-tree linus ^v${VERSION}.${PATCHLEVEL}.${SUBLEVEL}${EXTRAVERSION} | wc -l)
to get an approximate distance from the base version

Another version issue is use of "localversion" ... I use it to tag
kernels with a summary of the config file I used during build (e.g.
-tiger-smp, or -generic-up).  Looking at the results you've collected
so far, there appear to be a variety of other conventions in use
that prevent aggregation of results.

-Tony
