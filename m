Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264059AbSIQLQx>; Tue, 17 Sep 2002 07:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264060AbSIQLQx>; Tue, 17 Sep 2002 07:16:53 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:39345 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S264059AbSIQLQw>; Tue, 17 Sep 2002 07:16:52 -0400
Date: Tue, 17 Sep 2002 13:22:15 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: James Cleverdon <jamesclv@us.ibm.com>
cc: Mark Knecht <mknecht@controlnet.com>, linux-kernel@vger.kernel.org
Subject: Re: APIC IRQs
In-Reply-To: <200209161717.02057.jamesclv@us.ibm.com>
Message-ID: <Pine.GSO.3.96.1020917130620.16296D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Sep 2002, James Cleverdon wrote:

> For APICs, when two interrupts are present when interrupts are enabled, the 
> one with the highest interrupt vector number will be taken first.  Vectors 
> are statically assigned to the PCI slots, starting at 0x40 or 0x41.  So, the 

 Vectors start from 0x31.  That's what IRQ 0 gets.  The interval is 8, so
the following vectors are 0x39, 0x41, and so on.

> last PCI interrupt source in the MPS table will be the highest priority.  

 Not necessarily -- after reaching the reserved range, i.e. 0xef, the
allocation wraps around to the previous base plus one.  So for the second
pass vectors start from 0x32, for the third -- 0x33, etc.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

