Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270856AbTGVObh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 10:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270862AbTGVObe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 10:31:34 -0400
Received: from sunpizz1.rvs.uni-bielefeld.de ([129.70.123.31]:64948 "EHLO
	mail.rvs.uni-bielefeld.de") by vger.kernel.org with ESMTP
	id S270856AbTGVOap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 10:30:45 -0400
Subject: Firmware loading problem
From: Marcel Holtmann <marcel@holtmann.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Manuel Estrada Sainz <ranty@debian.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 22 Jul 2003 16:45:28 +0200
Message-Id: <1058885139.2757.27.camel@pegasus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I installed linux-2.6.0-test1-ac2 and tried to port my driver for the
BlueFRITZ! USB Bluetooth dongle to 2.6. This device needs a firmware
download and I want to use the new firmware class for getting the
firmware file from userspace. After reading the documentation and
testing the driver samples I got the results that I expected.

My problem is now that the firmware loader is not working with my
firmware file and it seems that this is a problem of the file size,
because copying small files through the same interface is working fine.
This is the file I want to load:

-rw-r--r--  1 holtmann staff  418352 Jul 11 12:38 bfubase.frm

I have written my own firmware.agent hotplug script, which looks in
general something like this:

	echo 1 > $LOADING
	cp bfubase.frm $DATA
	echo 0 > $LOADING

Loading the above firmware file through this interface results in
different behaviours. The results are complete freezes, instant reboots,
X server crashes with black screens and sometimes I see an oops about
virtual memory, but it goes bye bye too fast to let me do anything
useful with it.

Are their any limitations with the sysfs binary file interface?

Regards

Marcel


