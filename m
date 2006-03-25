Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751026AbWCYVPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbWCYVPn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 16:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbWCYVPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 16:15:43 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:64784 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750744AbWCYVPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 16:15:42 -0500
Date: Sat, 25 Mar 2006 22:15:41 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Darren Jenkins <darrenrjenkins@gmail.com>
Subject: Re: [2.6 patch] fix array over-run in efi.c
Message-ID: <20060325211541.GA4053@stusta.de>
References: <20060325115853.GB4053@stusta.de> <Pine.LNX.4.61.0603251941111.29793@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0603251941111.29793@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2006 at 07:41:56PM +0100, Jan Engelhardt wrote:
> 
> >-		for (i = 0; i < sizeof(vendor) && *c16; ++i)
> >+		for (i = 0; i < (sizeof(vendor) - 1) && *c16; ++i)
> 
>                 for (i = 0; i <  sizeof(vendor) - 1  && *c16; ++i)
> Should suffice.

That's irrelevant.
The important question is readability.

> Jan Engelhardt

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

