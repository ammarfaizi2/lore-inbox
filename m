Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422996AbWAMWCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422996AbWAMWCb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 17:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422997AbWAMWCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 17:02:31 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:18707 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1422996AbWAMWCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 17:02:31 -0500
Date: Fri, 13 Jan 2006 22:02:15 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Tejun Heo <htejun@gmail.com>
Cc: axboe@suse.de, bzolnier@gmail.com, james.steward@dynamicratings.com,
       jgarzik@pobox.com, James.Bottomley@SteelEye.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET] block: fix PIO cache coherency bug
Message-ID: <20060113220215.GD31824@flint.arm.linux.org.uk>
Mail-Followup-To: Tejun Heo <htejun@gmail.com>, axboe@suse.de,
	bzolnier@gmail.com, james.steward@dynamicratings.com,
	jgarzik@pobox.com, James.Bottomley@SteelEye.com,
	linux-kernel@vger.kernel.org
References: <11371658562541-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11371658562541-git-send-email-htejun@gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2006 at 12:24:16AM +0900, Tejun Heo wrote:
> Russell, can you please test whether this fixes the bug on arm?  If
> this fixes the bug and people agree with the approach, I'll follow up
> with patches for yet unconverted drivers and documentation update.

Unfortunately, as I previously explained, I'm not able to test this.
The reason is that in order to reproduce the bug, you need a system
with a VIVT write-back write-allocate cache.

Unfortunately, the few systems I have which have such a cache do not
have IDE, SCSI nor SATA (not even PCMCIA.)  I suggest contacting the
folk who reported the bug in the first instance.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
