Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288761AbSAQOFw>; Thu, 17 Jan 2002 09:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288760AbSAQOFl>; Thu, 17 Jan 2002 09:05:41 -0500
Received: from trained-monkey.org ([209.217.122.11]:23565 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP
	id <S288761AbSAQOFa>; Thu, 17 Jan 2002 09:05:30 -0500
From: Jes Sorensen <jes@trained-monkey.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15430.55835.417188.484427@trained-monkey.org>
Date: Thu, 17 Jan 2002 09:05:15 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        marcelo@conectiva.com.br (Marcelo Tosatti)
Subject: Re: [patch] VAIO irq assignment fix
In-Reply-To: <E16RDJS-0003Ur-00@the-village.bc.nu>
In-Reply-To: <15430.5138.319243.798770@trained-monkey.org>
	<E16RDJS-0003Ur-00@the-village.bc.nu>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>> I have gotten a Sony VAIO R505TL laptop which has a Richo RL5C574
>> Cardbus controller however the broken bios doesn't assign an irq to
>> the controller even though it is attached.

Alan> Surely pci_enable_device should do that anyway?

The problem is that the interrupt is not set in the PIRQ table so if we
don't shoehorn it in, the interrupt source wont be found.

Jes
