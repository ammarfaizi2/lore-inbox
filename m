Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264646AbTB0LaL>; Thu, 27 Feb 2003 06:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264654AbTB0LaL>; Thu, 27 Feb 2003 06:30:11 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:19983 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S264646AbTB0LaK>; Thu, 27 Feb 2003 06:30:10 -0500
Date: Thu, 27 Feb 2003 12:40:27 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Pablo B <pablob127@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DTE 3181e
Message-ID: <20030227114027.GB4095@merlin.emma.line.org>
Mail-Followup-To: Pablo B <pablob127@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <20030226054404.85557.qmail@web40102.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030226054404.85557.qmail@web40102.mail.yahoo.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2003, Pablo B wrote:

> I am trying to use an ancient DTC 3181e SCSI card with
> the 2.4.20 kernel. However, whenever I load the
> g_NCR5380 module with a SCSI device on, it inmediately
> freezes the computer hard. The system gets completely
> hung, needs a hard reset to restart (no Alt-SysRq
> magic keys available).
> I've been looking for information on the Net, but I
> could not find anybody with similar problems.
> 
> Does anyone have current information about this
> card/driver combination? Or whom I could reach to ask
> questions about the driver?

If I recall correctly (I sold my DTC-3181E), you need to use the
sym53c400 driver with dtc3181e= option (check the sym53c400 code or
README in drivers/scsi/ for the exact syntax), not the g_NCR5380 driver.

It used to work for me, but I don't recall which kernel version, likely
2.2.18 or something.

Better get a real adaptor if you have a spare PCI slot though... the
DTC-3181E doesn't do DMA as far as I know and will hardly exploit the
Fast-SCSI bandwidth to the full extent: ISA is the bottle's neck.

-- 
Matthias Andree
