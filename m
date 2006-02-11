Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbWBKRHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbWBKRHK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 12:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbWBKRHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 12:07:10 -0500
Received: from iris.cobite.com ([208.222.83.2]:64724 "EHLO
	email-pri.cobite.com") by vger.kernel.org with ESMTP
	id S932339AbWBKRHI (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 12:07:08 -0500
Subject: question about values in /sys/block/???/device/type
From: David Mansfield <lkml@dm.cobite.com>
To: Linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sat, 11 Feb 2006 12:07:06 -0500
Message-Id: <1139677626.18414.26.camel@gandalf.cobite.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

I'm trying to debug why my firewire harddrive is no longer handled by
'hald', and it seems that the value in /sys/block/sdb/device/type is 14
(0x0e) and this is not a value handled by the program.  It is expecting
0x00 for disk and 0x05 for cdrom. 

In the hald source (blockdev.c), there is a comment:

    /* These magic values are documented in the kernel source */

and for the life of me I cannot find out where.  You can't exactly grep
for 0x0e and get anything meaningful! 

Does anyone know?

BTW, I'm running the FC4 kernel: 2.6.15-1.1830_FC4 on ia32, if that
matters.

David Mansfieldq

