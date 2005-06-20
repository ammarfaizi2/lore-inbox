Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbVFTV1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbVFTV1a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 17:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbVFTVYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 17:24:14 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:30164 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261541AbVFTVVP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:21:15 -0400
Date: Tue, 21 Jun 2005 02:48:26 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@muc.de>
Subject: Re: 2.6.12-git1 broken on x86_64 (works on 2.6.12)
Message-ID: <20050620211826.GD4622@in.ibm.com>
Reply-To: dipankar@in.ibm.com
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

If ABAT copies an older .config with CONFIG_FUSION=y, the new config
disables it since it now has two different options CONFIG_FUSION_SPI
and CONFIG_FUSION_FC. Try manually setting those two new fusion options.

I had to do this in 2.6.12-mm1.

Thanks
Dipankar
