Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263262AbTK3WAv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 17:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264406AbTK3WAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 17:00:51 -0500
Received: from linux-bt.org ([217.160.111.169]:57238 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S263262AbTK3WAu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 17:00:50 -0500
Subject: [PATCH] User level driver support for input subsystem
From: Marcel Holtmann <marcel@holtmann.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1070229623.9032.372.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 30 Nov 2003 23:00:23 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

this is a backport of the user level driver support for input subsystem
from 2.6. Please consider including them into 2.4.24. We want to use it
for Bluetooth HID devices which need access to the input subsystem from
userspace.

Regards

Marcel


Please do a

        bk pull http://linux-mh.bkbits.net/uinput-2.4

This will update the following files:

 CREDITS                      |    1 
 Documentation/Configure.help |    9 
 Documentation/devices.txt    |    1 
 drivers/input/Config.in      |    1 
 drivers/input/Makefile       |    1 
 drivers/input/uinput.c       |  428 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/uinput.h       |   79 +++++++
 7 files changed, 520 insertions(+)

through these ChangeSets:

<marcel@holtmann.org> (03/11/30 1.1196)
   [PATCH] User level driver support for input subsystem
   
   This driver adds support for user level drivers for input
   subsystem accessible under char device /dev/input/uinput.



