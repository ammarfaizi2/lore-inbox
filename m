Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315394AbSEGXOX>; Tue, 7 May 2002 19:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315445AbSEGXOW>; Tue, 7 May 2002 19:14:22 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:48904 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315394AbSEGXOW>; Tue, 7 May 2002 19:14:22 -0400
Subject: Re: x86 question: Can a process have > 3GB memory?
To: ctwhite@us.ibm.com (Clifford White)
Date: Wed, 8 May 2002 00:33:14 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <OF4EFD903E.F8196584-ON87256BB2.007DEC69@boulder.ibm.com> from "Clifford White" at May 07, 2002 04:03:09 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E175ESI-0000PX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We'd like to go > 3GB of memory per process.
> Is this possible on a 32-bit machine? I have been reading the various

Yes and no...

> Any pointers would be appreciated. The Intel ESMA (Extended Server Memory
> Arch) page states that it's possible, but.....how?

Remember DOS and EMM memory expansion. Basically that is what you come
down to. Allocate multiple large shared memory segments, attach the one
you need each time and implement software segment swapping.

That should have you diving for an AMD hammer or IA64 box as soon as they
come out 8)
