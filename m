Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbULAIiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbULAIiF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 03:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbULAIiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 03:38:04 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:2519 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261345AbULAIhs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 03:37:48 -0500
Date: Wed, 1 Dec 2004 09:37:43 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: linux-kernel@vger.kernel.org
Subject: RE: Walking all the physical memory in an x86 system
In-Reply-To: <C863B68032DED14E8EBA9F71EB8FE4C205805A9F@azsmsx406>
Message-ID: <Pine.LNX.4.53.0412010936560.17975@yvahk01.tjqt.qr>
References: <C863B68032DED14E8EBA9F71EB8FE4C205805A9F@azsmsx406>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>[Jon M. Hanson] I tried the filp_open() approach like this:
>
>struct file *mem_fd;
>
>mem_fd = filp_open("/dev/mem", O_RDONLY | O_LARGEFILE, 0);
>
>I then have a check if IS_ERR(mem_fd) is true immediately afterwards
>along with a printk saying it failed. This condition is true when I ran
>it. It seems to fail with -EACCES (permission denied) as the error code.
>
>I can see the exact code that's causing the -EACCES in open_namei(). It
>makes a check if the thing being opened is a character device and
>returns the -EACCES, so obviously filp_open() can't do this.

Mh, non-files... here's a real blind shot: cdev_open



Jan Engelhardt
-- 
ENOSPC
