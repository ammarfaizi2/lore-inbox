Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbTI0DdD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 23:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbTI0DdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 23:33:03 -0400
Received: from [24.76.142.122] ([24.76.142.122]:43781 "HELO
	signalmarketing.com") by vger.kernel.org with SMTP id S262074AbTI0DdB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 23:33:01 -0400
Date: Fri, 26 Sep 2003 22:33:00 -0500 (CDT)
From: Derek Foreman <manmower@signalmarketing.com>
To: linux-kernel@vger.kernel.org
Subject: CDROM_SEND_PACKET oddity
Message-ID: <Pine.LNX.4.58.0309262131110.15317@uberdeity.signalmarketing.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The example code from
http://www.ussg.iu.edu/hypermail/linux/kernel/0202.0/att-0603/01-cd_poll.c

Does not behave as expected on my 2.6.0-test5 system.  While the command 
seems to be successfully sent - 2 of my drives report it as an invalid 
opcode - for the other 2 drives, the buffer comes back all zeros.
(actually, the buffer's contents will remain in whatever state they're in 
before the ioctl is called)

Sending the same command to those 2 drives with SG_IO results in the 
expected behaviour.
