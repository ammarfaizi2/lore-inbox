Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbVBRREU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbVBRREU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 12:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVBRREU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 12:04:20 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:59834 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S261404AbVBRRET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 12:04:19 -0500
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f78a4b55513a35eed5eaa1173ff0d4e9@freescale.com>
Content-Transfer-Encoding: 7bit
Cc: Becky Gill <bgill@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: use of TASK_SIZE to determine user/kernel
Date: Fri, 18 Feb 2005 11:04:20 -0600
To: Linux Kernel list <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are looking at a 32-bit architecture implementation were we can have 
distinct address spaces for user and kernel, thus allowing 4G's for 
each.  In doing this we have come across the use of TASK_SIZE to 
determine if an address is user vs kernel (example mm/memory.c).  I'm 
wondering is it just sufficient to set TASK_SIZE to 0xffffffff?  This 
feels wrong to me, since it would imply that all the places that are 
testing will never need access to the kernel memory space.

thanks

- kumar

