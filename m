Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270541AbRHNKuj>; Tue, 14 Aug 2001 06:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270549AbRHNKua>; Tue, 14 Aug 2001 06:50:30 -0400
Received: from sunrise.pg.gda.pl ([153.19.40.230]:43666 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S270541AbRHNKuO>; Tue, 14 Aug 2001 06:50:14 -0400
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200108141049.MAA29682@sunrise.pg.gda.pl>
Subject: Re: [PATCH] fix 2.4.8 compile errors
To: richbaum@acm.org (Rich Baum)
Date: Tue, 14 Aug 2001 12:49:58 +0200 (MET DST)
Cc: rmk@arm.linux.org.uk (Russell King), linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds)
In-Reply-To: <1013D72A35C6@coral.indstate.edu> from "Rich Baum" at Aug 14, 2001 05:32:16 AM
Reply-To: ankry@green.mif.pg.gda.pl
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rich Baum wrote:"
> diff -urN -X dontdiff linux-2.4.8/drivers/net/Config.in 
...
> +   if [ "$ARCH" = "arm" ]; then
...
> +   if [ "$ARCH" = "sh" ]; then

I don't remember the reason the ARCH variable was almost removed from
configuration some time ago (probably for better build dependencies check),
but wouldn't it better to replace the above by:

if [ "$CONFIG_ARM" = "y" ]; then

if [ "$CONFIG_SUPERH" = "y" ]; then

?

Andrzej
-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
