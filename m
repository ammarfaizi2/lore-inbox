Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129663AbRCAPmL>; Thu, 1 Mar 2001 10:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129664AbRCAPmC>; Thu, 1 Mar 2001 10:42:02 -0500
Received: from mailhost.mipsys.com ([62.161.177.33]:25032 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S129663AbRCAPlw>; Thu, 1 Mar 2001 10:41:52 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: The IO problem on multiple PCI busses
Date: Thu, 1 Mar 2001 16:41:26 +0100
Message-Id: <19350124091310.4277@mailhost.mipsys.com>
In-Reply-To: <19350124090521.18330@mailhost.mipsys.com>
In-Reply-To: <19350124090521.18330@mailhost.mipsys.com>
X-Mailer: CTM PowerMail 3.0.6 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>If we want to go a bit further, and allow ISA drivers that don't have a
>pci_dev structure to work on legacy devices on any bus, we could provide
>a set of function of the type
>
> int isa_get_bus_count();
> unsigned long isa_get_bus_io_offset(int busno);

I would add that I'd prefer to keep it separated from the PCI layer in
that sense that it can also help handle 16bits ISA-like IO busses on
embedded hardware which may (will most of the time) not have anything
like a PCI bus. Having the ability to map PCI<->ISA bus numbers should be
an option.

Ben.

