Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129911AbRBSOuz>; Mon, 19 Feb 2001 09:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130219AbRBSOup>; Mon, 19 Feb 2001 09:50:45 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:54993 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129911AbRBSOub>; Mon, 19 Feb 2001 09:50:31 -0500
Date: Mon, 19 Feb 2001 15:48:05 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Igor Yanover <yanover@vipe.technion.ac.il>
cc: linux-kernel@vger.kernel.org
Subject: Re: More on IO-APIC trouble
In-Reply-To: <Pine.LNX.4.10.10102171401540.7724-100000@vipe.technion.ac.il>
Message-ID: <Pine.GSO.3.96.1010219150733.10451B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Feb 2001, Igor Yanover wrote:

>     Recently I came across two more things, that are possibly related to
> IO-APIC problems:
> 1)http://xfree86.org/pipermail/xpert/2001January/004751.html
>     Someone with SMP that has problem with interrupt delivery (stuck
> interrupt). Only in SMP mode and this is not NE2000 related.

 I've already talked to the guy.  Some software reprograms the 8254 timer
to a weird mode (one-shot, IIRC; I have full details if anyone wants to
work on it).  I suspect XFree86 to be at fault. 

> 2)http://developer.intel.com/software/idap/media/pdf/copy.pdf ( Page 8
> footer)
>    It turns out, that there's an errata in early Pentium III revisions,
> that could corrupt data written to IO-APIC. ( Only if SSE write is
> followed by an APIC write)

 We don't do SSE writes before APIC writes (they must mean the local APIC
-- I can't check the doc at the moment).

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

