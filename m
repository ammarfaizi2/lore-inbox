Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264683AbSJPBjQ>; Tue, 15 Oct 2002 21:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264689AbSJPBjQ>; Tue, 15 Oct 2002 21:39:16 -0400
Received: from dyn-212-232-39-6.ppp.tiscali.fr ([212.232.39.6]:41486 "EHLO LAP")
	by vger.kernel.org with ESMTP id <S264683AbSJPBjP>;
	Tue, 15 Oct 2002 21:39:15 -0400
Message-ID: <030701c274b5$ad424820$0200000a@LAP>
From: "Vadim Lebedev" <vadim@7chips.com>
To: <linux-kernel@vger.kernel.org>
Subject: Fast data acquisition
Date: Wed, 16 Oct 2002 03:45:15 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 16 Oct 2002 01:45:16.0450 (UTC) FILETIME=[AD424820:01C274B5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm designing a solution for high speed data acquisition. The solution will
be based on a Pentium class processor running Linux 2.4.x
The data will be acquired over ISA bus using DMA at the rate of 52Mbit per
second and then sent over TCP/IP on Ethernet 100MB connecttion to host
computer.


I wonder how to design a driver for the data acquistion bord that will
minimize data copying.
I have 2 ideas:

1) the application will open the driver and use a sendfile(devicefd,
socketfd, ....) call
2) To have the driver DMA data into the kernel buffer and then calling
sock_sendpage directly from the driver.



Do i need to implement some special functionality in the driver to realize
1) or a sendfile will work with an fd to any character device as source?

Maybe somebody already implement something similar?

Please CC me the responce

Thanks
Vadim


