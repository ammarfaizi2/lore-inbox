Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288664AbSAIRTS>; Wed, 9 Jan 2002 12:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288246AbSAIRSX>; Wed, 9 Jan 2002 12:18:23 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:6920 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S288787AbSAIRQq>; Wed, 9 Jan 2002 12:16:46 -0500
Date: Wed, 9 Jan 2002 18:16:35 +0100
From: Martin Mares <mj@ucw.cz>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: State of the new config & build system
Message-ID: <20020109171635.GQ4019@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020106095549.A664@ucw.cz> <23415.1010355599@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23415.1010355599@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith,

> The main reason is to convert absolute dependency names to $(xxx)
> followed by a relative name, where xxx is one of the KBUILD_OBJTREE or
> KBUILD_SRCTREE_nnn variables.  This conversion allows users to rename
> their source and object trees and to compile on one machine and install
> on another over NFS without being bitten by absolute dependencies.  I
> really need to do that conversion using the current values of the
> kbuild variables, the variables might have changed on the next make.

Yes, I understand, but this could be done as well at the start of the
make run, couldn't it?

> My new design for module symbol versions requires that the version data
> be stored immediately after the compile.  That also requires processing
> after each compile using the current environment.

This sounds worse ... damned modversions, I still think it was one of the
biggest mistakes in Linux history and an one which will be probably very
hard to get rid of.  Anyway, why do you need to process it immediately?

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Minimalist definition of maximalism: `more!'.
