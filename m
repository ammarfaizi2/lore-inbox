Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264301AbTEZGu3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 02:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264302AbTEZGu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 02:50:29 -0400
Received: from smtp.b-online.gr ([212.152.79.22]:19638 "EHLO smtp.b-online.gr")
	by vger.kernel.org with ESMTP id S264301AbTEZGu2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 02:50:28 -0400
Date: Mon, 26 May 2003 10:08:35 +0300
From: Natsakis Konstantinos <cyfex@mail.com>
To: linux-kernel@vger.kernel.org
Subject: Proposal: Bastard floppy and ramdisk block device.
Message-Id: <20030526100835.1949c872.cyfex@mail.com>
X-Mailer: Sylpheed version 0.7.4claws (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've written a module for the kernel that handles a new binary block device (i call it /dev/flpemu) which acts partly as a virtual floppy. The handler is a stripped down version of the ramdisk driver with the addition that it supports the FDGETPRM ioctl. The return structure of this ioctl is arbitrarily defined in the source. For example it can be set to always return the parameters for a 1440k 3 1/2 floppy.

The use of this bastard device is to be able to install lilo on a floppy disk image previously uploaded on the /dev/flpemu's buffer.

This allows the automation of the process of creating bootable floppy disks as there is no need for an actual floppy disk or even a floppy controller. It certainly made my life easier. So what I'm asking is:

Is there any interest for such a strange thing?

And if yes what would be the best way to implement it?
Would it be better to add 2 ioctls to the ramdisk driver (One to set the parameters and one to get them) instead of creating a new device?

Is this maybe stupid altogether?
Should it be implemented on lilo's side alone?
Should this be extended maybe to support a wider range of floppy ioctl in order to be usefull?

thank you.

cyfex
