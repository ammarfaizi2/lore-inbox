Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265311AbRGBCZ4>; Sun, 1 Jul 2001 22:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265338AbRGBCZq>; Sun, 1 Jul 2001 22:25:46 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:55787 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265311AbRGBCZc>; Sun, 1 Jul 2001 22:25:32 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 1 Jul 2001 19:25:11 -0700
Message-Id: <200107020225.TAA02230@adam.yggdrasil.com>
To: kaos@ocs.com.au, rhw@MemAlpha.CX
Subject: Re: [PATCH] Re: 2.4.6p6: dep_{bool,tristate} $CONFIG_ARCH_xxx bugs
Cc: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Does anyone know if there is any code that would break if
we put quotation marks around the $CONFIG_xxxx references in the
dep_xxx commands in all of the Config.in files?  In other words,
change all commands of the form

dep_tristate  CONFIG_FOO 'Foo on x86/pci machines'  $CONFIG_PCI $CONFIG_X86

to

dep_tristate  CONFIG_FOO 'Foo on x86/pci machines'  "$CONFIG_PCI" "$CONFIG_X86"

      Then, we could change dep_{bool,tristate} to only treat "" as "n",
in its dependency parameters without effecting how undefined variables
are treated elsewhere.  For example, CONFIG_FOO being undefined would
still cause "make oldconfig" to treat it as "NEW" and ask the user
about it.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

