Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261694AbVCVT0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbVCVT0I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 14:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbVCVTZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 14:25:49 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:47330 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261685AbVCVTZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 14:25:09 -0500
Date: Tue, 22 Mar 2005 20:25:05 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: linux-os <linux-os@analogic.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: lseek on /proc/kmsg
In-Reply-To: <Pine.LNX.4.61.0503221320090.5551@chaos.analogic.com>
Message-ID: <Pine.LNX.4.61.0503222020470.32461@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0503221320090.5551@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


> how am I supposed to clear the kmsg buffer since it's not a terminal??

fd = open("/proc/kmsg", O_RDONLY | O_NONBLOCK);
while(read(fd, buf, sizeof(buf)) > 0);
if(errno == EAGAIN) { printf("Clear!\n"); }

This is language (spoken-wise) neutral :p



Jan Engelhardt
-- 
