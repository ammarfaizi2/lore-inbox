Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316862AbSEVFwO>; Wed, 22 May 2002 01:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316864AbSEVFwN>; Wed, 22 May 2002 01:52:13 -0400
Received: from mail013.syd.optusnet.com.au ([210.49.20.171]:11457 "EHLO
	mail013.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S316862AbSEVFwN>; Wed, 22 May 2002 01:52:13 -0400
Date: Wed, 22 May 2002 15:55:15 +1000
From: Andrew Pam <xanni@glasswings.com.au>
To: andre@linux-ide.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Initialisation bug in IDE patch
Message-ID: <20020522155515.F2437@kira.glasswings.com.au>
In-Reply-To: <20020522151510.A2437@kira.glasswings.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2002 at 03:15:10PM +1000, Andrew Pam wrote:
> In the latest available kernel 2.2 IDE patch "ide-2.2.20.01102002.patch"
> there is a bug that prevents ide_setup in drivers/block/ide.c
> from accepting kernel parameters selecting special IDE hardware.
> 
> The ide_init_default_hwifs() function in include/asm-*/ide.h fails to
> initialise the "hw_regs_t hw" variable, thus leaving uninitialised data
> in some fields.  Specifically, the "chipset" field is uninitialised which
> causes the "if (hwif->chipset != ide_unknown)" test in drivers/block/ide.c
> to always fail with the error message " -- BAD OPTION".

This bug also appears to be present in the mainline 2.4 kernel IDE code.
I haven't checked the 2.5 code yet.

Regards,
	Andrew Pam
-- 
mailto:xanni@xanadu.net                         Andrew Pam
http://www.xanadu.com.au/                       Chief Scientist, Xanadu
http://www.glasswings.com.au/                   Technology Manager, Glass Wings
http://www.sericyb.com.au/                      Manager, Serious Cybernetics
http://two-cents-worth.com/?105347&EG		Donate two cents to our work!
P.O. Box 477, Blackburn VIC 3130 Australia	Phone +61 401 258 915
