Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272417AbTHNPTq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 11:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272423AbTHNPTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 11:19:46 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:51719 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S272417AbTHNPTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 11:19:44 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test3: extra ttyS in /sys/class/tty
Date: Thu, 14 Aug 2003 18:55:31 +0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308141855.31137.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

{pts/1}% dmesg | grep ttyS
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS2 at I/O 0xd000 (irq = 9) is a 16550A

{pts/1}% l -d /sys/class/tty/ttyS*
/sys/class/tty/ttyS0/  /sys/class/tty/ttyS1/  /sys/class/tty/ttyS2/
/sys/class/tty/ttyS3/
{pts/1}% cat /sys/class/tty/ttyS*/dev
4:64
4:65
4:66
4:67

not that I find sysfs that useful for cdevs in general but I am just curiouos 
- where does it come from?

I have irtty_sir loaded if it matters.

-andrey
