Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283876AbRLMQOA>; Thu, 13 Dec 2001 11:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284337AbRLMQNn>; Thu, 13 Dec 2001 11:13:43 -0500
Received: from [195.25.229.189] ([195.25.229.189]:13138 "EHLO
	mailrennes.rennes.si.fr.atosorigin.com") by vger.kernel.org
	with ESMTP id <S284336AbRLMQNU> convert rfc822-to-8bit; Thu, 13 Dec 2001 11:13:20 -0500
Message-ID: <003001c183f0$c934b970$8a140237@rennes.si.fr.atosorigin.com>
From: "Yann E. MORIN" <yann.morin.1998@anciens.enib.fr>
To: "DevilKin" <devilkin@gmx.net>
Cc: "lkml" <linux-kernel@vger.kernel.org>
In-Reply-To: <20011213155532Z284289-18284+114@vger.kernel.org>
Subject: Re: User/kernelspace stuff to set/get kernel variables
Date: Thu, 13 Dec 2001 17:11:12 +0100
Organization: ENIB - Anciens
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 13 Dec 2001 16:11:13.0355 (UTC) FILETIME=[C92B91B0:01C183F0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi DK.

> Basically: is it possible to - one way or another - set variables at
> kernel boot and read those using userspace utilities?
> for instance: i boot my kernel (using any old bootmanager that
> accepts kernel params)
> LILO: linux network=dhcp
> and later, in the init scripts, i check the value of this variable
> using some sort of userspace program, and if it happends to be
> 'dhcp' i'll invoke the dhcp client.
[--8<--SNIP--8<--]

You'll at least find that in /proc/1/environ

It's a null-terminated list of strings that consist of what you want.
You'll see it as well while dumping the kernel log (dmesg) at the
begining. For my machine, I have:

--8<--
Kernel command line: auto BOOT_IMAGE=linux root=806 devfs=mount idebus=33
--8<--

Regards,
Yann.

--
.---------------------------.----------------------.------------------.
|       Yann E. MORIN       |  Real-Time Embedded  | ASCII RIBBON /"\ |
| phone (+33/0) 299 055 231 |  Software  Designer  |   CAMPAIGN   \ / |
|   fax (+33/0) 299 055 221 °----------------------:   AGAINST     X  |
| yann.morin@atosorigin.com    www.atosorigin.com  |  HTML MAIL   / \ |
°--------------------------------------------------°------------------°


