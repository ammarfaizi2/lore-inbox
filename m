Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965123AbVHJOQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965123AbVHJOQZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 10:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965124AbVHJOQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 10:16:25 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:47790 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S965123AbVHJOQY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 10:16:24 -0400
Message-ID: <1123683383.42fa0c374dc41@imp6-q.free.fr>
Date: Wed, 10 Aug 2005 16:16:23 +0200
From: jfontain@free.fr
To: linux-kernel@vger.kernel.org
Subject: 2.6.13-rc6: 3c574 fails: interrupt(s) dropped: solved (more)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.5
X-Originating-IP: 195.101.92.253
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please CC me as I am not subscribed)

I wrote yesterday:
---
Just wanted to thank you for solving the above problem, where a 3com pcmcia card
failed on an older laptop.
I saw in the 2.6.13-rc6 log that some work on yenta and PCI had been done. So I
tried kernel 2.6.12-1.1456_FC5 from the Fedora development repository, and I got
it to work but only with the irqpoll option (details including dmesg output at
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=163952).
---
Actually, using the irqpoll option, I got:
  hdc: cdrom_pc_intr: The drive appears to be confused (ireason= 0x01)
then a panic after mounting a NFS share.
However, using irqfixup instead now results in a working stable system.

--
Jean-Luc
