Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286263AbRLJNj1>; Mon, 10 Dec 2001 08:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286235AbRLJNjR>; Mon, 10 Dec 2001 08:39:17 -0500
Received: from [213.156.59.6] ([213.156.59.6]:27667 "HELO
	smail2.dmz1.icn.siemens.it") by vger.kernel.org with SMTP
	id <S286261AbRLJNjL>; Mon, 10 Dec 2001 08:39:11 -0500
Message-ID: <000901c18180$01bac960$11b41d8d@icn.siemens.it>
From: "Lanfranco Salinari" <lanfranco.salinari@icn.siemens.it>
To: "Abraham vd Merwe" <abraham@2d3d.co.za>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <3BEC87A2@webmail> <20011210100918.E1502@crystal.2d3d.co.za>
Subject: Re: Question about sniffers and linux
Date: Mon, 10 Dec 2001 14:38:36 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: Abraham vd Merwe <abraham@2d3d.co.za>
To: salinarl <Lanfranco.Salinari@icn.siemens.it>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Sent: Monday, December 10, 2001 9:09 AM
Subject: Re: Question about sniffers and linux

>Hi salinarl!
>
>You don't need to write a kernel module to do this.
>
>Use RAW sockets. (See man 2 socket). If you're not interested in the link
>layer, you can also use DGRAM sockets to get everything from layer 3 and up
>(ip, arp, etc.)
>

Thank you for your answer, Abraham!
Perhaps I did not explain myself very well: I know about RAW sockets, but
the problem is that, for example, PPP headers are not passed to packet
sockets (for outgoing packets), because they are added inside the PPP driver
after the call to dev_queue_xmit_nit().
I don't know if this problem is typical of PPP, but it seems quite general,
to me. I think Ethernet headers are a special case, because they are taken
from a
cache and added in the IP layer, so they are visible to packet sockets.
Can someone please tell me if I'm wrong?
Best regards,

Lanfranco






