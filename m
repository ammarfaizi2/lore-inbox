Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263114AbUCMPcs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 10:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263115AbUCMPcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 10:32:47 -0500
Received: from webmail.b.astral.ro ([194.102.255.8]:47293 "EHLO
	mail.b.astral.ro") by vger.kernel.org with ESMTP id S263114AbUCMPcq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 10:32:46 -0500
Subject: sysfs method for registering/unregistering ide devices ?
From: Paul Ionescu <paul@acorp.ro>
To: linux-kernel@vger.kernel.org
Message-Id: <1079191509.8073.13.camel@t40>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 13 Mar 2004 17:25:10 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Is there any possibility to unregister/scan ide devices with sysfs ?
I've searched lkml and linux-ide list archives and I didn't found any
answers.
Is there any sysfs file like /sys/..../registered, where you could echo
0 or 1 if you want to register or unregister a specific interface ?

Till now, I used hdparm -U/-R option for this task.
While this is still available in kernel 2.6, the implementation of
 HDIO_UNREGISTER_HWIF and  HDIO_SCAN_HWIF seems more like a hack than a
sane implementation.
Reasons:
Unregister and then register the same device, and you will have
different files for it int procfs and sysfs.
For unregistering or registering a device, you need at least a valid
block device. So I cannot unregister all my drives, and register them
again (or at least not at the same time).



