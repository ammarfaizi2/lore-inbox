Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130386AbRCETpF>; Mon, 5 Mar 2001 14:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130390AbRCEToz>; Mon, 5 Mar 2001 14:44:55 -0500
Received: from mail.ansp.br ([143.108.25.7]:11525 "HELO www.ansp.br")
	by vger.kernel.org with SMTP id <S130386AbRCETom>;
	Mon, 5 Mar 2001 14:44:42 -0500
Message-ID: <3AA3ECA3.55A05B8B@ansp.br>
Date: Mon, 05 Mar 2001 16:44:35 -0300
From: Marcus Ramos <marcus@ansp.br>
Organization: Fapesp
X-Mailer: Mozilla 4.73 [en] (X11; I; FreeBSD 4.1-RELEASE i386)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Making changes to 3c90X.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am developing an application for which I need to make small changes to
the source code of 3c90x.c (3com ethernet driver). Indeed, I need to
access - and modify - the contents of the packets right before they are
sent on the wire. After examining sk_buff.h, function NICSendPacket of
3c90x.c and reading chapter 14 (Network Drivers) of the book Linux
Device Drivers, I concluded that SocketBuffer->data points to the first
octet of data in the packet.

My question is: can I access the contents of the buffer simply by

*(SocketBuffer->data)
*(SocketBuffer->data+1)
*(SocketBuffer->data+2) etc ?

What is the layout of the octets starting at data ? Eth header, IP
header, TCP header etc ,or ?

Can I write new contents back to the buffer the same way ?

Thanks in advance,
Marcus.


