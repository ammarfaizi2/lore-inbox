Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284541AbRLRSlq>; Tue, 18 Dec 2001 13:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284491AbRLRSk1>; Tue, 18 Dec 2001 13:40:27 -0500
Received: from m851-mp1-cvx1c.edi.ntl.com ([62.253.15.83]:20718 "EHLO
	pinkpanther.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S284521AbRLRSjL>; Tue, 18 Dec 2001 13:39:11 -0500
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200112181513.fBIFDco15925@pinkpanther.swansea.linux.org.uk>
Subject: Re: 2.4.16 deadlock in kswapd
To: akpm@zip.com.au (Andrew Morton)
Date: Tue, 18 Dec 2001 15:13:38 +0000 (GMT)
Cc: popo.enlighted@free.fr (FORT David), linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <3C1E2A19.BC654FF0@zip.com.au> from "Andrew Morton" at Dec 17, 2001 09:23:37 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Trace; c01117b5 <flush_tlb_page+75/80>
> > Trace; c012f052 <swap_out+312/4b0>
> > ...
> 
> Dodgy hardware, I'm afraid - it looks like a cross-CPU interrupt
> was sent but not received.  Not uncommon.

Andrea claimed there were races in the x86 ipi code. I dont know if his
change was applied however. The x86 messaging is reliable (you'll see
showers of apic errors before it fails) but does sometimes replay a message
which is much fun

