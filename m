Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129397AbRBXRcz>; Sat, 24 Feb 2001 12:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129447AbRBXRcp>; Sat, 24 Feb 2001 12:32:45 -0500
Received: from web1301.mail.yahoo.com ([128.11.23.151]:27409 "HELO
	web1301.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129397AbRBXRck>; Sat, 24 Feb 2001 12:32:40 -0500
Message-ID: <20010224173234.14673.qmail@web1301.mail.yahoo.com>
Date: Sat, 24 Feb 2001 09:32:34 -0800 (PST)
From: Mark Swanson <swansma@yahoo.com>
Subject: 242-ac3 loop bug
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First, good job on the loop device. It's rock stable for me - except
when I try to load the blowfish module which oops the kernel and
crashes the loop device:-) No problem, I just use another cipher.

The bug I'm reporting is that when a loop device is in use the load of
the machine stays at 1.00 even though nothing is happening. If I umount
the loop filesystem the load goes down to 0.00.

> ps -aux | grep loop
1674 tty1     DW<   0:00 [loop0]

The system is doing nothing to the loop filesystem.
Strange that the process isn't logging any cpu usage time. It's
definately responsible for the 1.00 load.



__________________________________________________
Do You Yahoo!?
Get email at your own domain with Yahoo! Mail. 
http://personal.mail.yahoo.com/
