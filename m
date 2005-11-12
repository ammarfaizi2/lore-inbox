Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbVKLR5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbVKLR5a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 12:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbVKLR53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 12:57:29 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:56591 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932442AbVKLR52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 12:57:28 -0500
Date: Sat, 12 Nov 2005 18:57:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [2.6 patch] removed useless SCSI_GENERIC_NCR5380_MMIO
Message-ID: <20051112175726.GA21448@stusta.de>
References: <20051112043707.GX5376@stusta.de> <1131819625.18258.16.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131819625.18258.16.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2005 at 06:20:25PM +0000, Alan Cox wrote:
> On Sad, 2005-11-12 at 05:37 +0100, Adrian Bunk wrote:
> > This patch removes the useless SCSI_GENERIC_NCR5380_MMIO.
> > 
> > It's useless, since SCSI_G_NCR5380_MEM != CONFIG_SCSI_G_NCR5380_MEM.
> > 
> > This issue exists at least since kernel 2.6.0 and since it seems noone 
> > noticed it I'd say we can safely remove it.
> 
> 
> Its a one line bugfix so make the bugfix. There are often drivers that
> needed tiny fixes and it turned out that
> 
> - Vendors had it in their patch tree for years
> - The one person using it fixed it and didnt bother telling l/k cos they
> though l/k was full of arrogant assholes who would just laugh at them
> - The few users are still on 2.4 but will move to 2.6
> 
> Now when its a major rewrite to fix up some prehistoric piece of crap it
> makes sense to dump it if nobody uses it, when you have a one line fix
> required its a bit daft not to fix it.

The part that is not a one-line fix is to move the SCSI_G_NCR5380_MEM 
code away from the ISA legacy API, but if this is among the patches Al 
wants to send later today the rest is really only a one-line fix.

> Alan

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

