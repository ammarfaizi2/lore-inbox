Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263262AbSJCMPK>; Thu, 3 Oct 2002 08:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263263AbSJCMPK>; Thu, 3 Oct 2002 08:15:10 -0400
Received: from zeus.kernel.org ([204.152.189.113]:14015 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S263262AbSJCMPJ>;
	Thu, 3 Oct 2002 08:15:09 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200210031217.g93CHo1m005676@green.mif.pg.gda.pl>
Subject: Re: (PATCH) Re: 2.5.40: make menuconfig error
To: carlos@techlinux.com.br
Date: Thu, 3 Oct 2002 14:17:50 +0200 (CEST)
Cc: linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <200210031133.g93BXE120744@sunrise.pg.gda.pl> from "Andrzej Krzysztofowicz" at Oct 03, 2002 01:33:17 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >  Q> ./scripts/Menuconfig: MCmenu74: command not found
> 
> The following patch fix it
> 
> --- linux-2.5.40/sound/Config.in	Tue Oct  1 04:06:30 2002
> +++ linux-2.5/sound/Config.in	Wed Oct  2 07:27:04 2002
> @@ -31,10 +31,7 @@
>  if [ "$CONFIG_SND" != "n" -a "$CONFIG_ARM" = "y" ]; then
>    source sound/arm/Config.in
>  fi
> -if [ "$CONFIG_SND" != "n" -a "$CONFIG_SPARC32" = "y" ]; then
> -  source sound/sparc/Config.in
> -fi
> -if [ "$CONFIG_SND" != "n" -a "$CONFIG_SPARC64" = "y" ]; then
> +if [ "$CONFIG_SND" != "n" -a "$CONFIG_SPARC32" = "y" ] || [ "$CONFIG_SND" != "n" -a "$CONFIG_SPARC64" = "y" ];then
                                                         ^^^^
and you will break xconfig.

>    source sound/sparc/Config.in
>  fi

Valid syntax is described in

Documentation/kbuild/config-language.txt

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Gdansk University of Technology
