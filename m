Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314444AbSFISfL>; Sun, 9 Jun 2002 14:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314458AbSFISfK>; Sun, 9 Jun 2002 14:35:10 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:60088
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S314444AbSFISfI>; Sun, 9 Jun 2002 14:35:08 -0400
Date: Sun, 9 Jun 2002 11:34:00 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.21: kbuild changes broke filenames with commas
Message-ID: <20020609183400.GU14252@opus.bloom.county>
In-Reply-To: <20020609175804.B8761@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 09, 2002 at 05:58:04PM +0100, Russell King wrote:

> With the latest kbuild version in 2.5.21, we are unable to build the
> following files:
> 
[snip]
> linux/drivers/scsi/53c7,8xx.c
> linux/drivers/scsi/53c7,8xx.h
> linux/drivers/scsi/53c7,8xx.scr

How about we remove these alltogether?  The ncr53c8xx and sym-2 drivers
both support the 53c810, 53c825, and 53c820 devices and there's a 'common'
53c7xx backend which handles the 53c700, 53x700-66 53c710 and 53c720
chipsets that the 53c7,8xx driver handles.  The only minor issue is that
if there's any ISA (PCI?) cards with these chipsets would need a new
front-end to detect the cards.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
