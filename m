Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131497AbREHKnn>; Tue, 8 May 2001 06:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131481AbREHKnd>; Tue, 8 May 2001 06:43:33 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:61707 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131480AbREHKnX>; Tue, 8 May 2001 06:43:23 -0400
Subject: Re: [PATCH] x86 page fault handler not interrupt safe
To: torvalds@transmeta.com (Linus Torvalds)
Date: Tue, 8 May 2001 11:45:28 +0100 (BST)
Cc: bgerst@didntduck.org (Brian Gerst), nigel@nrg.org,
        alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.31.0105071443080.1195-100000@penguin.transmeta.com> from "Linus Torvalds" at May 07, 2001 02:44:22 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14x4zi-0005RA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 7 May 2001, Brian Gerst wrote:
> >
> > Keep in mind that regs->eflags could be from user space, and could have
> > some undesirable flags set.  That's why I did a test/sti instead of
> > reloading eflags.  Plus my patch leaves interrupts disabled for the
> > minimum time possible.
> 
> The plain "popf" should be ok: the way intel works, you cannot actually
> use popf to set any of the strange flags (if vm86 mode etc).
> 
> I like the size of this alternate patch.

I dont see where the alternative patch ensures the user didnt flip the
direction flag for one

