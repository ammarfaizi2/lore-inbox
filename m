Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286895AbSA1WIH>; Mon, 28 Jan 2002 17:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286934AbSA1WH4>; Mon, 28 Jan 2002 17:07:56 -0500
Received: from colorfullife.com ([216.156.138.34]:8974 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S286895AbSA1WHo>;
	Mon, 28 Jan 2002 17:07:44 -0500
Message-ID: <002101c1a848$383e6750$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Daniel Jacobowitz" <dan@debian.org>, <linux-kernel@vger.kernel.org>,
        "Andrew Morton" <akpm@zip.com.au>
In-Reply-To: <E16VJu7-0001w0-00@the-village.bc.nu>
Subject: Re: [PATCH?] Crash in 2.4.17/ptrace
Date: Mon, 28 Jan 2002 23:07:30 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
> > For framebuffers addresses, there is no page structure, and then the
> > page reference count updates read/write to random memory.
>
> If it is a physical pci bus object why do we need to refcount it,
> surely "no page" is ok. Its just up to the driver not to do anything
> stupid and the core code to honour the pci/pci transfer quirks (or
> when faced with a hard one just say "no")
>
With multi-threaded apps, munmap() during O_DIRECT is possible. vma
structures don't contain a reference count.

For ptrace, taking the physical address from the PTE and ioremapping it
temporarily would work, but ...

--
    Manfred


