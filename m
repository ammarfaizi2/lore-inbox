Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263504AbTLONL6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 08:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263544AbTLONL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 08:11:57 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:31201 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S263504AbTLONL4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 08:11:56 -0500
Date: Mon, 15 Dec 2003 14:11:55 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Bob <recbo@nishanet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: Re: Working nforce2, was Re: Fixes for nforce2 hard lockup,
 apic, io-apic, udma133 covered
In-Reply-To: <3FDAFF79.5080509@nishanet.com>
Message-ID: <Pine.LNX.4.55.0312151403190.26565@jurand.ds.pg.gda.pl>
References: <200312132040.00875.ross@datscreative.com.au> <3FDAFF79.5080509@nishanet.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Dec 2003, Bob wrote:

> APIC error on CPU0: 02(02)
> what?? no crash though.
[...]
> bob@where cat /proc/interrupts
>            CPU0      
>   0:    3350153    IO-APIC-edge  timer
>   1:       5775    IO-APIC-edge  i8042
>   2:          0          XT-PIC  cascade
>   8:          1    IO-APIC-edge  rtc
>   9:          0   IO-APIC-level  acpi
>  12:       5385    IO-APIC-edge  i8042
>  14:         10    IO-APIC-edge  ide0
>  15:         10    IO-APIC-edge  ide1
>  16:    1717957   IO-APIC-level  ide2, ide3, eth0
>  19:     472929   IO-APIC-level  ide4, ide5
>  21:          0   IO-APIC-level  NVidia nForce2
> NMI:        822
> LOC:    3350073
> ERR:         35
> MIS:      15818

 It looks like the infamous APIC delivery bug -- the "MIS" counter shows
how many level-triggered interrupts has been erronously delivered as
edge-triggered ones.  No wonder the system shows instability -- you have 
noise problems at the APIC bus.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
