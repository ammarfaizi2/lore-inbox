Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269107AbRHBQiL>; Thu, 2 Aug 2001 12:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269101AbRHBQiC>; Thu, 2 Aug 2001 12:38:02 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:27667 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267985AbRHBQhs>; Thu, 2 Aug 2001 12:37:48 -0400
Subject: Re: [RFT] #2 Support for ~2144 SCSI discs
To: rgooch@ras.ucalgary.ca (Richard Gooch)
Date: Thu, 2 Aug 2001 17:34:18 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        adilger@turbolinux.com (Andreas Dilger), linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
In-Reply-To: <no.id> from "Richard Gooch" at Aug 02, 2001 09:47:18 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15SLQQ-00011K-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That said, in 2.5 I want to see us move away from using device numbers
> as the fundamental device handle and move to device instance
> structures. That's a lot cleaner, and BTW is devfs-neutral
> (i.e. doesn't need devfs to work). Exposing a 32 bit dev_t to
> user-space is acceptable, but internally it should be shunned.

You need it internally otherwise you are screwed the moment you have 65536
volumes mounted - because you run out of unique device identifiers for stat.

Fortunately 32bit dev_t (not kdev_t .. which I think is what you are talking
about and will I assume go pointer to struct) is only one syscall change
