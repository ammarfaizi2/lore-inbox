Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbWAQSsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbWAQSsh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 13:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbWAQSsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 13:48:36 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:29704 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932399AbWAQSsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 13:48:35 -0500
Date: Tue, 17 Jan 2006 19:48:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Vitaly Bordug <vbordug@ru.mvista.com>, jgarzik@pobox.com,
       saw@saw.sw.com.sg, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] remove drivers/net/eepro100.c
Message-ID: <20060117184834.GD19398@stusta.de>
References: <20060105181826.GD12313@stusta.de> <20060115161958.07e3c7f1@vitb.dev.rtsoft.ru> <20060115160340.6f8cc7d6@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060115160340.6f8cc7d6@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2006 at 04:03:40PM -0800, Stephen Hemminger wrote:
> On Sun, 15 Jan 2006 16:19:58 +0300
> Vitaly Bordug <vbordug@ru.mvista.com> wrote:
> 
> > On Thu, 5 Jan 2006 19:18:26 +0100
> > Adrian Bunk <bunk@stusta.de> wrote:
> > 
> > > This patch removes the obsolete drivers/net/eepro100.c driver.
> > > 
> > > Is there any known problem in e100 still preventing us from removing 
> > > this driver (it seems noone was able anymore to verify the ARM problem)?
> > > 
> > I think I am recalling some problems on ppc82xx, when e100 was stuck on startup,
> > and eepro100 worked just fine. 
> > 
> > Even if the patch below will be scheduled for application, we need to set up enough time 
> > for approval that e100 will be fine for all the up-to-date hw; or it should be fixed/updated before eepro100 removal.
> > 
> > > 
> > > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > > 
> > >
> 
> How about doing what was done with devfs removal, and remove it
> from the config menu system for a couple of releases.

IMHO the devfs case was different since the complete devfs removal patch 
(although being straightforward) touches many files.

In the eepro100 case (assuming there were no more known regressions in 
the e100 driver), reverting the removal patch would be trivial.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

