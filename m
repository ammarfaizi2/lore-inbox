Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266476AbRGCINI>; Tue, 3 Jul 2001 04:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266474AbRGCIM7>; Tue, 3 Jul 2001 04:12:59 -0400
Received: from t2.redhat.com ([199.183.24.243]:62454 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S266473AbRGCIMq>; Tue, 3 Jul 2001 04:12:46 -0400
To: Russell King <rmk@arm.linux.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Woodhouse <dwmw2@infradead.org>,
        David Howells <dhowells@redhat.com>, Jes Sorensen <jes@sunsite.dk>,
        arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] I/O Access Abstractions 
In-Reply-To: Your message of "Mon, 02 Jul 2001 19:11:29 BST."
             <20010702191129.A29246@flint.arm.linux.org.uk> 
Date: Tue, 03 Jul 2001 09:12:44 +0100
Message-ID: <3953.994147964@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Russell King <rmk@arm.linux.org.uk> wrote:
> They _ARE_ different, because people connect these chips in many different
> ways.  For example:

Also hence the mess in serial.c. On the board I'm currently dealing with, the
PC16550 chip is connected to the memory space with registers at 4-byte
intervals because the chip is an 8-bit chip connected to a 32-bit data bus
(and so ignored addr lines A0 and A1). Whereas on the PC, various serial
register sets appear generally in I/O port space at 1-byte intervals from some
base address.

This could be greatly simplified with the method I'm proposing. The resource
access function could make the address space for that device to be eight
consecutive registers regardless of the reality.

David
