Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262433AbVGLVDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbVGLVDF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 17:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262394AbVGLVAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 17:00:38 -0400
Received: from mailhub248.itcs.purdue.edu ([128.210.5.248]:62614 "EHLO
	mailhub248.itcs.purdue.edu") by vger.kernel.org with ESMTP
	id S262427AbVGLVAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 17:00:23 -0400
Message-ID: <42D42FA0.4060802@purdue.edu>
Date: Tue, 12 Jul 2005 16:01:20 -0500
From: Chase Douglas <cndougla@purdue.edu>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050630)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sysfs and configuration of a driver
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075
X-PerlMx-Virus-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to update the ati_remote module so that it is configurable
without having to change the source and recompile. I'm rather new to
kernel module development and was wondering how I should go about
creating an interface for configuration. My current implementation
creates a device node for configuration. When you read from it, it dumps
key bindings for the remote. When you write to it, you can change the
key bindings like this:

echo "play KIND_FILTERED 207" > /dev/ati_remote

Which would change the play button on the remote to send the KEY_PLAY
(207 in linux/input.h) button instead of what was previously configured.
This works alright, but it seems to me that this should be handled in
sysfs. I was thinking that since hardly anyone would have more than one
remote, there should be one interface that would configure any remote
that is plugged into the computer. It should be permanent in my opinion
so I thought it should go somewhere in /sys/module/ati_remote/.

Would this be a good way of configuring the remote? If it is, how can I
create a sysfs file in the module directory and not the actual usb
device directory?

If this isn't a good way, how should it be done?

Also, how could a permanent configuration be achieved so that if you
reboot the computer or re-modprobe the driver, your previous mappings
are still intact?

Thank you

P.S.: Please CC me to your responses


