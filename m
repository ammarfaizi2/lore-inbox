Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbTIHPGT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 11:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbTIHPGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 11:06:19 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:50097 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP id S262375AbTIHPGS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 11:06:18 -0400
Date: Mon, 8 Sep 2003 17:06:11 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: linux-kernel@vger.kernel.org, mathieu.desnoyers@polymtl.ca,
       mingo@redhat.com
Subject: Re: PROBLEM: APIC on a Pentium Classic SMP, kernel 2.4.21-pre5 to 2.4.23-pre3
In-Reply-To: <200309080933.h889X06U011447@harpo.it.uu.se>
Message-ID: <Pine.GSO.3.96.1030908170018.27835B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Sep 2003, Mikael Pettersson wrote:

> >IRQ problems with APIC enabled on a Neptune chipset, Pentium 90 SMP.
> >
> >Description
> >
> >Since kernel 2.4.21-pre2, IRQ problems are present on my Pentium 90 SMP, wi=
> >th
> >APIC enabled. It works well with 2.4.20 with APIC enabled, or with newer
> >kernels with "noapic" kernel option.
> 
> There were a lot of I/O-APIC & MP table parsing changes in 2.4.21
> for clustered apic. Chances are something there broke on your
> ancient BIOS & mobo. I can't immediately see anything obviously
> broken in 2.4.21: you'll have to identify the first pre-patch where
> things broke and then test or revert it piece by piece.

 The log shows the system is using a default MP configuration (i.e. no MP
table, only a suitable header).  The recent changes definitely broke such
systems -- someone doing them seems to have not cared about the default
configurations.  I've noticed the breakage recently and put it on my to-do
list, but unfortunately I have no time to code a fix now.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

