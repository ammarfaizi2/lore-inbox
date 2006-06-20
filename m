Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965090AbWFTJ2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965090AbWFTJ2q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 05:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965225AbWFTJ2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 05:28:46 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:31135 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S965090AbWFTJ2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 05:28:46 -0400
Date: Tue, 20 Jun 2006 11:28:35 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: elevator.h problem
Message-ID: <Pine.LNX.4.61.0606201126001.2481@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


I am trying to compile a module that requires elv_requeue_request.
I include <linux/elevator.h>, but that fails. Now that elevator.h includes 
blkdev.h (to get at the reqeust_queue_t typedef -- see next post), 
blkdev.h wants elv_dequeue_request, but which is defined in elevator.h. 
This circular dependency is really a problem, does anyone have 
an adequate fix? 2.6.17.

Jan Engelhardt
-- 
