Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275021AbTHLC5W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 22:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275022AbTHLC5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 22:57:22 -0400
Received: from 12-254-105-101.client.attbi.com ([12.254.105.101]:5901 "EHLO
	gw.kuetemeier.com") by vger.kernel.org with ESMTP id S275021AbTHLC5U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 22:57:20 -0400
Subject: 2.6.0-test3 kernel crash and some tests
From: Ronald Kuetemeier <ron_ker@kuetemeier.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1060657026.1411.36.camel@ronald.kuetemeier.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 11 Aug 2003 20:57:06 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1st. ES1371 reports unknown symbol when compiled as a module and tried
    to  insmod. Seems to work when compiled into the kernel.

2nd. usb-storage, seems not to work with scsi. Mount reports sda1 is not
     a valid block device. The Device attached is a camera and works
     fine in 2.4.X. No errors msg reported, scsi/usb reports right
     storage amount when the camera gets attached to the system,
     /proc/scsi/usb-storage/1 and all usbfs entries look ok. Just can't
     mount sda1.

3rd. Finally how to crash the kernel.  Use less to accidentally take a
     look at /proc/scsi/scsi.  The process will be in uninterruptible
     sleep and can't be killed.  Run a shutdown -r now, the file system
     you were on when you started less can not be umounted and the
     kernel crashes before restarting. SMP (2 X PIII) system. 

 Please cc me if you need more info, since I'm not on this list.

Ronald
 

