Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265055AbRFVSmO>; Fri, 22 Jun 2001 14:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265034AbRFVSmE>; Fri, 22 Jun 2001 14:42:04 -0400
Received: from [200.24.109.130] ([200.24.109.130]:59149 "EHLO
	earth.cj.osso.org.co") by vger.kernel.org with ESMTP
	id <S265055AbRFVSl4>; Fri, 22 Jun 2001 14:41:56 -0400
Message-ID: <3B3390F8.AC4B0F4E@osso.org.co>
Date: Fri, 22 Jun 2001 13:39:52 -0500
From: "Jhon H. Caicedo O." <jhcaiced@osso.org.co>
Organization: O.S.S.O
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: linux-kernel@vget.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: AMD756 PCI IRQ Routing Patch 0.2.0
In-Reply-To: <3B3343E6.122965AC@osso.org.co> <3B338E4E.D1FDD74D@mandrakesoft.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mozilla-Status: 0000
X-Mozilla-Status2: 00000000
X-UIDL: 3ada3da400000eae
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Jeff Garzik wrote:
> None of the other PCI IRQ routines print out IRQ routing messages, so
> these shouldn't either.  I assume this is debugging code?

Yes, the printks are only for debug and surely will be removed 
after some tests of the patch.
> 
> Further, the printks are potentially misleading, because pirq_amd756_get
> might not receive a valid irq, if 'pirq' is greater than 4.

With pirq > 4 pirq_amd756_get should return 0, i left the
printk just to see if this happens in some test.

In the original 2.4.5 kernel (without patch), I get irq=0 for pirq=4
and that was the cause of the error with a SMC Lucent CardBus Bridge.

Thanks,
--
Jhon H. Caicedo O. <jhcaiced@osso.org.co>
Observatorio Sismológico del SurOccidente O.S.S.O
http://www.osso.org.co
Cali - Colombia

