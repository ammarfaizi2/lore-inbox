Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281058AbRKPEVY>; Thu, 15 Nov 2001 23:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281076AbRKPEVF>; Thu, 15 Nov 2001 23:21:05 -0500
Received: from mercury.lss.emc.com ([168.159.40.77]:54800 "EHLO
	mercury.lss.emc.com") by vger.kernel.org with ESMTP
	id <S281049AbRKPEU7>; Thu, 15 Nov 2001 23:20:59 -0500
Message-ID: <FA2F59D0E55B4B4892EA076FF8704F553D188D@srgraham.eng.emc.com>
From: "chen, xiangping" <chen_xiangping@emc.com>
To: "'steve@chygwyn.com'" <steve@chygwyn.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: The memory usage of the network block device 
Date: Thu, 15 Nov 2001 23:20:54 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

I am trying to use the network block device in the Linux kernel.

The nbd works good in light io load, but during intensive io load
testing, it seems that it fails to release the memory fast enough.
Eventually the driver blocks at tcp_sendmsg, and waits for the
memory that seems never come. A simple bonnie test to create
a file about the size of the host memory shows the problem.

Is there any way to free up memory more quickly? or why the
network memory is held without being released?

Thanks,

Xiangping
