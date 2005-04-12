Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262084AbVDLJmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbVDLJmW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 05:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbVDLJmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 05:42:22 -0400
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:3539 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S262084AbVDLJmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 05:42:15 -0400
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Tue, 12 Apr 2005 11:41:48 +0200
MIME-Version: 1.0
Subject: throttling kernel messages: KERNEL: assertion (flags & MSG_PEEK) failed at net/ipv4/tcp.c (1282)
Message-ID: <425BB3FC.154.BAE5FC@rkdvmks1.ngate.uni-regensburg.de>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-P=3.92.0+V=3.92+U=2.07.092+R=04 April 2005+T=102704@20050412.092805Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm affected by the (in)famous bug:
Apr 12 07:03:02 mailgate kernel: recvmsg bug: copied D640F0D1 seq D640F679
Apr 12 07:03:02 mailgate kernel: KERNEL: assertion (flags & MSG_PEEK) failed at 
net/ipv4/tcp.c (1282)
Apr 12 07:03:02 mailgate kernel: recvmsg bug: copied D640F0D1 seq D640F679
Apr 12 07:03:02 mailgate kernel: KERNEL: assertion (flags & MSG_PEEK) failed at 
net/ipv4/tcp.c (1282)

(Kernel of SuSE Linux 9.2, 2.6.8-24.13-default #1 Fri Mar 18 10:19:42 UTC 2005 
i686 i686 i386 GNU/Linux)

The kernel spits out hundreds to thousand messages per second, making klogd and 
syslogd quite busy, and my messages file stopped growing at 2GB.

I'd suggest to enable throttling for this message, or trigger a panic/reboot, or 
maybe even fix the bug or message. ;-)

Regards,
Ulrich

