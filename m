Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268358AbTBNLDz>; Fri, 14 Feb 2003 06:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268361AbTBNLDz>; Fri, 14 Feb 2003 06:03:55 -0500
Received: from green.mif.pg.gda.pl ([153.19.42.8]:7173 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S268358AbTBNLDy>; Fri, 14 Feb 2003 06:03:54 -0500
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200302141113.h1EBDUiR003386@green.mif.pg.gda.pl>
Subject: Re: 2.4.21-pre4-ac4 make xconfig fails
To: bryan@bogonomicon.net
Date: Fri, 14 Feb 2003 12:13:30 +0100 (CET)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
       linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <200302141106.h1EB6OO13604@sunrise.pg.gda.pl> from "Andrzej Krzysztofowicz" at Feb 14, 2003 12:06:26 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I also see this, Debian testing based system, but I usually menuconfig 
> myself.
> 
> Looks like a parameter was forgotten.  I see a number of dep_tristate 
> lines with three parameters and the one it is choking on has only two.
> 
> dep_tristate '  ATI Radeon' CONFIG_DRM_RADEON     <<< chokes this line
> dep_tristate '  Intel I810' CONFIG_DRM_I810 $CONFIG_AGP

According to Alan's changelog:
: o       Radeon no longer needs AGPgart                  (James McClain)

This line should probably be changed to

tristate '  ATI Radeon' CONFIG_DRM_RADEON

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Gdansk University of Technology
