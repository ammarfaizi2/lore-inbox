Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262415AbREXWQp>; Thu, 24 May 2001 18:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262413AbREXWQf>; Thu, 24 May 2001 18:16:35 -0400
Received: from user-vc8ftn3.biz.mindspring.com ([216.135.246.227]:41742 "EHLO
	mail.ivivity.com") by vger.kernel.org with ESMTP id <S262402AbREXWQ0>;
	Thu, 24 May 2001 18:16:26 -0400
Message-ID: <25369470B6F0D41194820002B328BDD207179D@ATLOPS>
From: Bharath Madhavan <bharath_madhavan@ivivity.com>
To: linux-kernel@vger.kernel.org
Subject: Accelerated TCP/IP support from kernel
Date: Thu, 24 May 2001 18:16:17 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
	I am looking into a scenario where we have a NIC which performs 
all the TCP/IP processing and basically the core CPU offloads all data from
the socket level interface onwards to this NIC. 
Can Linux do this as of now. I saw some limited support like TCP/IP
checksumming
being done in HW (ex: 3c905c) and linux supports it. I also saw the
ZERO_COPY
feature in linux code. 
My question is can there be support for entire (almost) TCP/IP to be
offloaded 
to a NIC card. I noticed some NIC cards by Alacritec and Applicom who have 
such NICs but it looks like the support from Linux would be quite a bit of
work.
Basically Linux needs to support all socket calls as it will usually but
the socket interface must be intelligent enough to call different drivers(!)
for those NIC cards and thus bypassing the whole of TCP/IP stack of Linux.
Is this possible at all and if so, is anyone doing this???
I talked to a vendor who does this NIC and he said that they provide a
library
for linux which means that they have proprietery functions for using their
NIC
and thus this cannot be used in the standard socket interface way. That is a
big
limitation and not of much use. Basically, I am looking into a case where 
the kernel code needs to be changed to handle this
Looking eagerly for some help/advice from you folks
Thanks a lot
Bharath
