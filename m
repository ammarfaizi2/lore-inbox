Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311653AbSCNQSi>; Thu, 14 Mar 2002 11:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311654AbSCNQSb>; Thu, 14 Mar 2002 11:18:31 -0500
Received: from green.mif.pg.gda.pl ([153.19.42.8]:57093 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S311653AbSCNQSO>; Thu, 14 Mar 2002 11:18:14 -0500
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200203141617.RAA17200@green.mif.pg.gda.pl>
Subject: Re: make xconfig question
To: root@codeman.linux-systeme.org
Date: Thu, 14 Mar 2002 17:17:56 +0100 (CET)
Cc: linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <200203141211.g2ECBq110052@sunrise.pg.gda.pl> from "Andrzej Krzysztofowicz" at Mar 14, 2002 01:11:53 PM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> what EXACTLY does that means:
> 
> root@codeman:/usr/src/linux# make xconfig
> rm -f include/asm
> ( cd include ; ln -sf asm-i386 asm)
> make -C scripts kconfig.tk
> make[1]: Entering directory `/usr/src/linux-2.4.18-mcp3-WOLK/scripts'
> cat header.tk >> ./kconfig.tk
> ./tkparse < ../arch/i386/config.in >> kconfig.tk
> statement not in menu

It means active statement (not define_* or if) located after
	mainmenu_name

but not between any
	mainmenu_option next_comment
	[...]
	endmenu
pair.
May be after last "endmenu" or between menus.
xconfig can't detect which file the problem is located in.

> make[1]: *** [kconfig.tk] Error 1
> make[1]: Leaving directory `/usr/src/linux-2.4.18-mcp3-WOLK/scripts'
> make: *** [xconfig] Error 2
> 
> I cannot figure out what i have modified wrong in the arch/i386/config.in
> And i don't understand what "statement not in menu" means EXACTLY.

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
