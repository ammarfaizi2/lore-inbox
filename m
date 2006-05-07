Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbWEGTbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWEGTbj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 15:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWEGTbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 15:31:39 -0400
Received: from hera.cwi.nl ([192.16.191.8]:18819 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S932217AbWEGTbj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 15:31:39 -0400
Date: Sun, 7 May 2006 21:31:37 +0200 (MEST)
From: <Andries.Brouwer@cwi.nl>
Message-Id: <200605071931.k47JVbs18224@apps.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: a Linux swap storm
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Earlier this evening I showed someone some pictures under X:

% display -size 300x300 *.jpg

(395 pictures, 315 MB). When display (from ImageMagick)
started to repeat, I exited the program.
At this moment the machine became unusable for twenty minutes
of solid disk activity.
No keystroke seen, not even the Ctrl-Alt-Backspace to kill X,
or Ctrl-Alt-F1 to switch consoles, no mouse movement seen,
vmstat did not produce any output for twenty minutes.

The vmstat 5 output was

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa

 0  3 315728   3164   4424   3356  646  382   792   382 2425   182  0  5  0 95
 1  1 316356   3856   4428   3572  454  366   507   366 2242   150  0  5  0 95
 0  1 317540   3784   4456   3664  530  578   590   578 2403   179  0  7  0 93
 0  1 306740   4240   4524   5372 127013 49878 129427 50061 405016 32901  0  4  0 95
 1  1 306712   3992   4536   5372   30    0    30     3  450   122  2  1 94  2
 0  0 306692   4016   4548   5372   18    0    18     3  402   134  2  2 96  1
 0  0 306692   4016   4560   5372    0    0     0     3  257    35  1  1 98  0

The machine is vanilla 2.6.14, 256MB, 550MB swap.

% rpm -qf `which X`
xorg-x11-server-6.8.2-100

I wonder what precisely happened. Is this an X bug? Or a kernel bug?
The effect is reproducible.

Andries

