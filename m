Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbTILViN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 17:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbTILViM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 17:38:12 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:25014 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S261566AbTILViI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 17:38:08 -0400
Date: Fri, 12 Sep 2003 23:38:03 +0200 (MEST)
Message-Id: <200309122138.h8CLc32K007912@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: bunk@fs.tum.de, macro@ds2.pg.gda.pl
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Sep 2003 21:07:28 +0200, Adrian Bunk <bunk@fs.tum.de> wrote:
>[
>My questions might sound silly - I simply don't have the x86
>knowledge, but I want to get the dependencies as good as possible.
>]
>
>All Cyrix/VIA/IDT/Transmeta processors have a working APIC?

None of them do.

>What about the original 386?

Nope.

>Then I can simply change it in my patch to
>
>config X86_GOOD_APIC
>        bool
>	depends on !CPU_586TSC
>	default y

GOOD_APIC is Intel P5MMX, Intel P6 and above, and AMD K7 and above.
Nothing else has GOOD_APIC: P5 Classic because of the bug, and the
rest because they don't have local APIC at all.

/Mikael
