Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262792AbSK0BNk>; Tue, 26 Nov 2002 20:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263321AbSK0BNk>; Tue, 26 Nov 2002 20:13:40 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:25496 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S262792AbSK0BNj>; Tue, 26 Nov 2002 20:13:39 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg Ungerer <gerg@snapgear.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]  v850 additions to include/linux/elf.h
References: <buoel987otw.fsf_-_@mcspd15.ucom.lsi.nec.co.jp>
	<1038325289.2594.37.camel@irongate.swansea.linux.org.uk>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 27 Nov 2002 10:19:06 +0900
In-Reply-To: <1038325289.2594.37.camel@irongate.swansea.linux.org.uk>
Message-ID: <buoel97kdx1.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> > This patch adds more stuff to include/linux/elf.h for the v850 (used by
> > the new module loader).
> 
> To save cluttering a linux/*.h file couldnt the module loader for v850 
> include an asm/*.h file holding the extra info ?

I suppose so, but the v850 is not exceptional in this regard.
The various relocation type constants (R_...) in elf.h are completely
unused in the kernel on _every_ architecture, except by the new module
loader.

If tidying is needed, then it seems like the best thing would be to move
all the arch-specific stuff into the corresponding <asm/elf.h> file for
each architecture.  I presume the reason this hasn't been done is simply
convention -- userland elf.h files are also giant conglomerations of
defines for every supported architecture ...

-Miles
-- 
Next to fried food, the South has suffered most from oratory.
  			-- Walter Hines Page
