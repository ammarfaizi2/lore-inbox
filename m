Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261488AbVFTVUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbVFTVUZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 17:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbVFTVPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 17:15:44 -0400
Received: from colin.muc.de ([193.149.48.1]:29706 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261584AbVFTVPL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:15:11 -0400
Date: 20 Jun 2005 23:15:04 +0200
Date: Mon, 20 Jun 2005 23:15:04 +0200
From: Andi Kleen <ak@muc.de>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-git1 broken on x86_64 (works on 2.6.12)
Message-ID: <20050620211504.GA28793@muc.de>
References: <563690000.1119299756@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <563690000.1119299756@flay>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 01:35:56PM -0700, Martin J. Bligh wrote:
> Fails to reboot, see:
> 
> http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/6035/debug/console.log
> 
> basically:
> 
> VFS: Cannot open root device "sda1" or unknown-block(0,0)
> Please append a correct "root=" boot option
> Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
> 
> Looks like it didn't find the SCSI card at all ... MPT fusion, IIRC.
> I'll poke at it a bit tommorow, but if you've got any good guesses as
> to what broke it, let me know (hopefully something trivial like config
> options).

Whatever driver serves sda1 does not seem to get started at all.
So probably config breakage.

-Andi
