Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267027AbSLXGTi>; Tue, 24 Dec 2002 01:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267030AbSLXGTi>; Tue, 24 Dec 2002 01:19:38 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:19158 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S267027AbSLXGTh>; Tue, 24 Dec 2002 01:19:37 -0500
To: "Andrey Panin" <pazke@orbita1.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] irq handling code consolidation (common part)
References: <20021224060331.GA1090@pazke>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
In-Reply-To: <20021224060331.GA1090@pazke>
Date: 24 Dec 2002 15:27:40 +0900
Message-ID: <buok7i0szhf.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Andrey Panin" <pazke@orbita1.ru> writes:
> this patch moves some common parts of irq handling code to one place.
> Arch specific patches will follow. Patch for i386 is tested and performed 
> well, but other arch specific patched are not. Please take a look.

Hmm, well it looks like it will work perfectly with the v850 (which
makes sense as it's mostly a copy of the i386 code).

What about request_irq/setup_irq?  The majority of architectures use
exactly the same code as i386 for these; a few do not, so perhaps this
is a case where a HAVE_ARCH_... define could be used.

[setup_irq even has this comment:

   /* this was setup_x86_irq but it seems pretty generic */
   int setup_irq(unsigned int irq, struct irqaction * new)
]

-Miles
-- 
Come now, if we were really planning to harm you, would we be waiting here, 
 beside the path, in the very darkest part of the forest?
