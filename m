Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbTIPMp4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 08:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbTIPMp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 08:45:56 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:40064 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP id S261247AbTIPMpz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 08:45:55 -0400
Date: Tue, 16 Sep 2003 14:42:29 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: bunk@fs.tum.de, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
In-Reply-To: <200309122138.h8CLc32K007912@harpo.it.uu.se>
Message-ID: <Pine.GSO.3.96.1030916143505.9516B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Sep 2003, Mikael Pettersson wrote:

> GOOD_APIC is Intel P5MMX, Intel P6 and above, and AMD K7 and above.
> Nothing else has GOOD_APIC: P5 Classic because of the bug, and the
> rest because they don't have local APIC at all.

 Other systems may (and do) have an external APIC.  This includes i486 and
all Pentium systems.  Note that the code doing a run-time check in
<asm/bugs.h> does a check for X86_FEATURE_APIC in
boot_cpu_data.x86_capability -- if the bit is reset then the local APIC is
external (there's no on-chip local APIC or it's disabled) and the test
does not panic() even if the stepping indicates the erratum is present.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

