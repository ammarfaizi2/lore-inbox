Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262289AbTINDv4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 23:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262291AbTINDvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 23:51:55 -0400
Received: from smtp3.att.ne.jp ([165.76.15.139]:41868 "EHLO smtp3.att.ne.jp")
	by vger.kernel.org with ESMTP id S262289AbTINDvx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 23:51:53 -0400
Message-ID: <1b7201c37a73$844b7030$2dee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test5 vs. Ethernet cards
Date: Sun, 14 Sep 2003 12:51:29 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to do a shutdown or reboot while an Ethernet card is present,
2.6.0-test5 continues to have problems which earlier 2.6.0-test versions
had, which can be solved by booting 2.4.19.

Shutdown messages appear on the text console as follows:
[...]
Shutting down PCMCIA unregister_netdevice: waiting for eth0 to become free.
Usage count = 1
unregister_netdevice: waiting for eth0 to become free. Usage count = 1
unregister_netdevice: waiting for eth0 to become free. Usage count = 1
unregister_netdevice: waiting for eth0 to become free. Usage count = 1
unregister_netdevice: waiting for eth0 to become free. Usage count = 1
unregister_netdevice: waiting for eth0 to become free. Usage count = 1
unregister_netdevice: waiting for eth0 to become free. Usage count = 1
unregister_netdevice: waiting for eth0 to become free. Usage count = 1
unregister_netdevice: waiting for eth0 to become free. Usage count = 1
[...]

The only way to shut down at this point is to turn off the power.

An alternative workaround is to manually type "ifconfig eth0 down" before
trying to shut down or reboot.  This takes a certain amount of activation of
human memory at the moment just before shutting down, and I have not been up
to the task.  Since this step was not necessary under 2.4.19, it is easier
to boot 2.4.19 instead.

Command "/etc/rc.d/pcmcia restart" suffers the same as a shutdown or reboot.
Again similarly, in 2.4.19 it works.

