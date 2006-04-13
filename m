Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWDMWtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWDMWtU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 18:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWDMWtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 18:49:20 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:42377 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751160AbWDMWtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 18:49:19 -0400
Date: Fri, 14 Apr 2006 00:49:12 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Flexible mem= parameter
Message-ID: <Pine.LNX.4.61.0604140036510.4365@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


mem= can be used to limit the amount of physical memory Linux uses. I 
presume that when specifying mem=256M only the memory from 0x0 to 
0x10000000 is used. Is there a way to tune mem= so that it will use
0x70000000 to 0x80000000? (A compile-time change would suffice.)


Background: I am trying to track down a nondeterministic (but 
reproducible) segfault while building big projects like gcc or glibc. I do 
not think it's a memory problem since it only showed up since I changed to 
gcc 4.1.0 and tweaked it to use -mcpu=ultrasparc (rather than -mcpu=v7) by 
default. I had been building gcc4 before with gcc3 a number of times w/o 
problems. I did ran a userspace memtester for approx 20 hours (`memtest` 
from debian).


Jan Engelhardt
-- 
