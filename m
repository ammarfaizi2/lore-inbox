Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966656AbWKTUi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966656AbWKTUi4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 15:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966660AbWKTUi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 15:38:56 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:17867 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S966656AbWKTUiz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 15:38:55 -0500
Date: Mon, 20 Nov 2006 21:38:39 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Simon Richter <Simon.Richter@hogyros.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: implement daemon() in the kernel
In-Reply-To: <4561ABB4.6090700@hogyros.de>
Message-ID: <Pine.LNX.4.61.0611202133170.31982@yvahk01.tjqt.qr>
References: <4561ABB4.6090700@hogyros.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 20 2006 14:20, Simon Richter wrote:
>
> - a reverse vfork()
>
>The child process is created and suspended, the parent continues to run
>until it calls exec() or _exit(). The good thing here is that it should
>be easy to implement as the infrastructure for suspending a process
>until another exits already exists.

How about the Cygwin way, i.e. 'suspend' the parent and let the child 
run after fork.

Your case: If it exec()s within a specific time limit, fine. If not, you 
can follow the suggestion to copy its entire memory space.


	-`J'
-- 
