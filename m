Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316900AbSHHIaZ>; Thu, 8 Aug 2002 04:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317387AbSHHIaY>; Thu, 8 Aug 2002 04:30:24 -0400
Received: from axp01.e18.physik.tu-muenchen.de ([129.187.154.129]:25096 "EHLO
	axp01.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S316900AbSHHIaY>; Thu, 8 Aug 2002 04:30:24 -0400
Date: Thu, 8 Aug 2002 10:33:42 +0200 (CEST)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: "David S. Miller" <davem@redhat.com>
Cc: kwijibo@zianet.com, <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG at tg3.c:1557
In-Reply-To: <20020807.154004.104177403.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0208081029320.4709-100000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2002, David S. Miller wrote:

>    From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
>    Date: Thu, 8 Aug 2002 00:10:31 +0200 (CEST)
> 
>    Since the insertion of a dummy write solved the problem, I would say it's 
>    the chipset's PCI reordering, which is malfunctioning in the 2466.
> 
> Roland can you retry using this patch?  The difference from
> my previous one is that when we use the indirect register
> writing of the mailbox registers, we offset into the GRCMBOX
> area of the chip registers.
> 
> This seems to be how Broadcom's driver does indirect accesses
> to mailbox registers.
> 
Will try in a minute. Do I understand it correctly, that only the mailbox 
writes must be done this way? And how do the pci_write_config_dword() 
functions ensure the right ordering? (Sorry, it was late yesterday and I 
somehow didn't find the definition of pci_*_config_*().)

Ciao,
					Roland

+---------------------------+-------------------------+
|    TU Muenchen            |                         |
|    Physik-Department E18  |  Raum    3558           |
|    James-Franck-Str.      |  Telefon 089/289-12592  |
|    85747 Garching         |                         |
+---------------------------+-------------------------+

