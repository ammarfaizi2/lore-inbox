Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270229AbRIECUf>; Tue, 4 Sep 2001 22:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270155AbRIECUZ>; Tue, 4 Sep 2001 22:20:25 -0400
Received: from rj.sgi.com ([204.94.215.100]:33177 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S270138AbRIECUV>;
	Tue, 4 Sep 2001 22:20:21 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <laughing@shared-source.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Linux 2.4.9-ac7 
In-Reply-To: Your message of "Mon, 03 Sep 2001 20:18:13 +0100."
             <20010903201813.A8730@lightning.swansea.linux.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 05 Sep 2001 12:19:52 +1000
Message-ID: <16898.999656392@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Sep 2001 20:18:13 +0100, 
Alan Cox <laughing@shared-source.org> wrote:
>2.4.9-ac7
>o	Add arch_init_modules hook			(Keith Owens)

To set the record straight: Maciej W. Rozycki did the real work, I just
merged his patch to 2.4.9-ac (and kept pestering AC until it went in :).

To ppc developers: modutils 2.4.8 added ftr_fixup support to modules,
the ftr fixup data is loaded in the archdata area.  With Maciej's patch
now in the -ac tree, it is easier to handle module archdata tables.

PPC needs code to handle ftr_fixup in modules, as well as the kernel.
See include/asm-mips/module.h::mips_module_init() for a clean example
of extracting archdata from a module, mips_init_modules() does the same
for the kernel.  arch/mips/kernel/traps.c runs the archdata for both
modules and kernel.

