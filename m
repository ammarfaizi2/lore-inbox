Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285024AbRLFG4C>; Thu, 6 Dec 2001 01:56:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285023AbRLFGzw>; Thu, 6 Dec 2001 01:55:52 -0500
Received: from news.heim1.tu-clausthal.de ([139.174.234.200]:29316 "EHLO
	neuemuenze.heim1.tu-clausthal.de") by vger.kernel.org with ESMTP
	id <S285022AbRLFGzh>; Thu, 6 Dec 2001 01:55:37 -0500
Date: Thu, 6 Dec 2001 07:55:55 +0100
From: Sven.Riedel@tu-clausthal.de
To: Daniel Stodden <stodden@in.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Message-ID: <20011206075555.A27857@moog.heim1.tu-clausthal.de>
In-Reply-To: <87d71s7u6e.fsf@bitch.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d71s7u6e.fsf@bitch.localnet>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2001 at 07:13:13AM +0100, Daniel Stodden wrote:
> over the last few days, i've been experiencing lengthy syslog
> complaints like the following:
> 
> Dec  6 06:33:42 bitch kernel: hdc: dma_intr: status=0x51 { DriveReady
> SeekComplete Error }
> Dec  6 06:33:42 bitch kernel: hdc: dma_intr: error=0x40 {
> UncorrectableError }, LBAsect=1753708, sector=188216
> Dec  6 06:33:42 bitch kernel: end_request: I/O error, dev 16:06 (hdc),
> sector 188216

Looks like your disk is trying to read defective sectors. I.e. the disk
is dying. Since you're using DTLA's I'd run the drive fitness test, and
if that finds any bad sectors contact IBM for exchange _without_ doing a
lowlevel format as the drive fitness test will suggest to you.

Sorry :)

Regs,
Sven

-- 
Sven Riedel                      sr@gimp.org
Osteroeder Str. 6 / App. 13      sven.riedel@tu-clausthal.de
38678 Clausthal                  "Call me bored, but don't call me boring."
                                 - Larry Wall 
