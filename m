Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263565AbTHXNGM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 09:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263525AbTHXNEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 09:04:49 -0400
Received: from law15-f75.law15.hotmail.com ([64.4.23.75]:11019 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263566AbTHXNDu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 09:03:50 -0400
X-Originating-IP: [212.152.91.92]
X-Originating-Email: [ef057@hotmail.com]
From: "Bryan K." <ef057@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: eric53@freemail.gr
Subject: delayed permission checks in 2.6
Date: Sun, 24 Aug 2003 13:03:49 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law15-F75VfbuhhhETA000031ba@hotmail.com>
X-OriginalArrivalTime: 24 Aug 2003 13:03:49.0659 (UTC) FILETIME=[291AF6B0:01C36A40]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While exploring some of the source I found out that some permission checks 
are made too late. For example the sys_mount function in 2.6-test1: It gets 
4 pages to put the type, the path, the dev name and the options. It then 
locks the kernel, check for magic numbers and other sanity checks, 
interprets the flags, does the mount point dentry lookup(which might spend 
some time sleeping) and after all that it checks for CAP_SYS_ADMIN. Is there 
any serious reason for this delay at the permission checks?

_________________________________________________________________
Add photos to your messages with MSN 8. Get 2 months FREE*. 
http://join.msn.com/?page=features/featuredemail

