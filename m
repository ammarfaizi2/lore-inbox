Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137057AbREKGUB>; Fri, 11 May 2001 02:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137058AbREKGTv>; Fri, 11 May 2001 02:19:51 -0400
Received: from sunrise.pg.gda.pl ([153.19.40.230]:20622 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S137057AbREKGTl>; Fri, 11 May 2001 02:19:41 -0400
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200105110619.IAA06283@sunrise.pg.gda.pl>
Subject: Re: Kernel 2.4.4, Adaptec 7880 on board controller
To: backes@rhrk.uni-kl.de
Date: Fri, 11 May 2001 08:19:35 +0200 (MET DST)
Cc: linux-kernel@vger.kernel.org (LINUX Kernel)
In-Reply-To: <XFMail.20010511064201.backes@rhrk.uni-kl.de> from "Joachim Backes" at May 11, 2001 06:42:01 AM
Reply-To: ankry@green.mif.pg.gda.pl
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Joachim Backes wrote:"
> when booting on a machine having an Adaptec 7880 on board
> controller (Kernel 2.4.4), then i get the following msg:
> ...
> SCSI subsystem driver Revision: 1.00
> request_module[scsi_hostadapter]: Root fs not mounted
> request_module[scsi_hostadapter]: Root fs not mounted
> request_module[scsi_hostadapter]: Root fs not mounted
> ...
> The aic7xxx scsi driver is not configured as module,
> but linked to the kernel.

Hmmm, I observe similar messages when
- scsi low-level driver (eg. sd, sr, st) linked to the kernel,
- no appropriate (corresponding to any of the above drivers) devices found
  on the hostadapters which have support linked to the kernel.

I don't think it is driver-specyfic. As I looked at the code it would be
difficult to avoid them (unless a linked-to-the-kernel function is able
to detect whether it is called from __init code or from a module
initialization code).

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk

