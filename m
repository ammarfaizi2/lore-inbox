Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754335AbWKMJ31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754335AbWKMJ31 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 04:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754310AbWKMJ30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 04:29:26 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:60346 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1754308AbWKMJ30 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 04:29:26 -0500
Date: Mon, 13 Nov 2006 10:29:01 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "lkml-2006i-ticket@limcore.pl" <lkml-2006i-ticket@limcore.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with file systems created on 2.6.18.x
In-Reply-To: <45581DB0.6030609@limcore.pl>
Message-ID: <Pine.LNX.4.61.0611131027240.26222@yvahk01.tjqt.qr>
References: <45581DB0.6030609@limcore.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Nov 13 2006 08:24, lkml-2006i-ticket@limcore.pl wrote:
>Hello, on two different boxes with 2.6.18.x kernels I created two file
>systems (ReiserFS and JFS). Both failed totally after about 1-2 days of
>using them.

The disk may have gone bad. (Unlikely, though)

>Dmesg reported corruption errors/warnings. When I unmounted and tried to
>remount - mound was unable to find superblocks.
>
>Before both failures I was playing with swap (swapoff -a swapon -a), I
>use encripted swap.
>
>So, perhaps there is a bug connected to some of the following aspects:
>- using newly or recently created file system (bug in code that is used
>to grow a short, "young" tree)
>- problems with swap / encrypted swap
>
>I saved image of 100 mb of the beginning of reiserfs partition after it
>failed,  I can sent it (or part of it) if anyone wants to investigate.
>
>Since I use grsecurity patch -

Recently there seem to be quite a few corruption reports involving 
setups with grsecurity.

If you can reproduce the problem with gr, see if you can reproduce it 
without gr.


	-`J'
-- 
