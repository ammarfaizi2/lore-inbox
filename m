Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266499AbUFQOFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266499AbUFQOFa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 10:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266506AbUFQOFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 10:05:30 -0400
Received: from chaos.analogic.com ([204.178.40.224]:7040 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266499AbUFQOFX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 10:05:23 -0400
Date: Thu, 17 Jun 2004 10:05:21 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: poll
Message-ID: <Pine.LNX.4.53.0406170954190.702@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,
Is it okay to use the 'extra' bits in the poll return value for
something? In other words, is the kernel going to allow a user-space
program to define some poll-bits that it waits for, these bits
having been used in the driver?

If not, then I guess I have to use POLLPRI and then the listener
will have to call an ioctl() function to find out what event it
really was. This seems very dumb.

I have three events I need to poll for, normal data available,
a mailbox message available, and another mailbox message available.

If, for instance, all the high-bits in the poll-flag are available,
then I could use two for the mail-box messages. However, if the kernel
uses them for something else, or ignores them, then I'm screwed and
have to make extra ioctl() calls to satisfy some abitrary rules.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


