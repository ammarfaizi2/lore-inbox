Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbVB1UIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbVB1UIF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 15:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbVB1UIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 15:08:05 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:14236 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261735AbVB1UHo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 15:07:44 -0500
Message-Id: <200502282007.j1SK7hgE031074@laptop11.inf.utfsm.cl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: ultralinux@vger.kernel.org
Subject: SPARC64: Modular floppy? 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Mon, 28 Feb 2005 17:07:43 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b2 (inti.inf.utfsm.cl [200.1.19.1]); Mon, 28 Feb 2005 17:07:43 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As things stand today, floppy can't be modular (even though the
configuration allows it!) because drivers/block/floppy.c references stuff
in arch/sparc64/kernel/entry.S which isn't included if the floppy
isn't. But that same code references symbols in floppy.c, so it doesn't
help making it depend on floppy (modular or not).

So, either the dependencies have to get fixed so floppy can't be modular
for this architecture, or the relevant functions have to move from entry.S
to the module. Last looks like a mess, splattering .S for sparc64 into
drivers, or moving it to arch. Or is there some way of building a module
from pieces in different directories under architecture control?

Or this can be declared an endearing quirk of Linux on SPARC ;-)
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
