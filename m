Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314075AbSEFCeN>; Sun, 5 May 2002 22:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314077AbSEFCeM>; Sun, 5 May 2002 22:34:12 -0400
Received: from mercury.lss.emc.com ([168.159.40.77]:63238 "EHLO
	mercury.lss.emc.com") by vger.kernel.org with ESMTP
	id <S314075AbSEFCeL>; Sun, 5 May 2002 22:34:11 -0400
Message-ID: <FA2F59D0E55B4B4892EA076FF8704F553D1A37@srgraham.eng.emc.com>
From: "chen, xiangping" <chen_xiangping@emc.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Kernel deadlock using nbd over acenic driver.
Date: Sun, 5 May 2002 22:26:57 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I encounter a deadlock situation when using nbd device over gigabit
ethernet. The network card is 3c 985 giga card using acenic driver. When the
network has some significant back ground traffic, even making a ext2 file
system can not succeed. When the deadlock happens, the nbd client daemon
just stuck in tcp_recvmsg() without receiving any data, and the sender
threads continue to send out requests until the whole system hangs. Even I
set the nbd client daemon SNDTIMEO, the nbd client daemon could not exit
from tcp_recvmsg(). 

Is there any known problem with the acenic driver? How can I identify it is
a problem of the NIC driver, or somewhere else?

Thanks for help!


Xiangping Chen 
