Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310581AbSCGW4V>; Thu, 7 Mar 2002 17:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310582AbSCGW4J>; Thu, 7 Mar 2002 17:56:09 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9222 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310581AbSCGWzs>; Thu, 7 Mar 2002 17:55:48 -0500
Subject: Re: [RFC] Arch option to touch newly allocated pages
To: dwmw2@infradead.org (David Woodhouse)
Date: Thu, 7 Mar 2002 23:09:03 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        phillips@bonn-fries.net (Daniel Phillips), yodaiken@fsmlabs.com,
        jdike@karaya.com (Jeff Dike), bcrl@redhat.com (Benjamin LaHaise),
        hpa@zytor.com (H. Peter Anvin), linux-kernel@vger.kernel.org
In-Reply-To: <1595.1015540989@redhat.com> from "David Woodhouse" at Mar 07, 2002 10:43:09 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16j70R-000463-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> alan@lxorguk.ukuu.org.uk said:
> >  Not having a fallback is unacceptable. Thats the real problem. You
> > can't go around pandering to sloppy coders who can't work a memory
> > allocator 
> 
> OTOH there is perhaps some justification for distinguishing between 'If you 
> fail this I'll tell the user -ENOMEM and continue happily on my way' 
> allocations and 'If you fail this I lose track of hardware state and all is 
> fucked till we reboot' ones.

None at all. If you needed the memory before you committed to an operation
you should have reserved it before you started. See "sloppy coders"
