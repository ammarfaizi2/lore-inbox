Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265432AbRF0WPL>; Wed, 27 Jun 2001 18:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265429AbRF0WPB>; Wed, 27 Jun 2001 18:15:01 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:10695 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S265432AbRF0WOt>;
	Wed, 27 Jun 2001 18:14:49 -0400
Message-ID: <3B3A5B00.9FF387C9@mandrakesoft.com>
Date: Wed, 27 Jun 2001 18:15:28 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: tom_gall@vnet.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: Changes for PCI
In-Reply-To: <3B3A58FC.2728DAFF@vnet.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Gall wrote:
>   The first part changes number, primary, and secondary to unsigned ints from
> chars. What we do is encode the PCI "domain" aka PCI Primary Host Bridge, aka
> pci controller in with the bus number. In our case we do it like this:
> 
> pci_controller=dev->bus->number>>8) &0xFF0000
> bus_number= dev->bus->number&0x0000FF),
> 
>   Is this reasonable for everyone?

Why not use sysdata like the other arches?

Changing the meaning of dev->bus->number globally seems pointless.  If
you are going to do that, just do it the right way and introduce another
struct member, pci_domain or somesuch.

	Jeff


-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
