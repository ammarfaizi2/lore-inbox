Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbVAGMe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbVAGMe0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 07:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVAGMeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 07:34:25 -0500
Received: from s1.mailresponder.info ([193.24.237.10]:62724 "EHLO
	s1.mailresponder.info") by vger.kernel.org with ESMTP
	id S261390AbVAGMeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 07:34:03 -0500
Subject: USB Storage "delay" when using udev
From: Mathieu Fluhr <mfluhr@nero.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Matthias Kiefer <mkiefer@nero.com>
Content-Type: text/plain
Organization: Ahead Software AG.
Date: Fri, 07 Jan 2005 13:31:04 +0100
Message-Id: <1105101064.1051.7.camel@c-l-175>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I don't know if someone has already fix this, but in the 2.6.x kernels,
when using udev file system, you encouter some kind of delay (something
like 2 or 3 seconds) when you plug in a USB hotplug device (like CD
recorder, or whatever...). 

I explain :

Normally, when you plug in such a device, the usb-storage module creates
a SCSI Generic device connected to your device for using it and adds it
to the /proc/scsi/scsi file.

With udev, it seems (I say it seems because I did not check the kernel
source yet) that the kernel is adding the SCSI Generic device in
the /proc file 2-3 seconds BEFORE this device gets useable (tested with
sg_scan).

Is it "normal" ?

Best Regards,
Mathieu


