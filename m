Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbVA2Xqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbVA2Xqd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 18:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbVA2Xqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 18:46:33 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:17168 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261607AbVA2XqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 18:46:25 -0500
Date: Sun, 30 Jan 2005 00:46:24 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/cdrom/isp16.c: small cleanups
Message-ID: <20050129234624.GC3185@stusta.de>
References: <20050129171108.GB28047@stusta.de> <58cb370e05012909513cc96b17@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e05012909513cc96b17@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2005 at 06:51:25PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> On Sat, 29 Jan 2005 18:11:08 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> > This patch makes the needlessly global function isp16_init static.
> > 
> > As a result, it turned out that both this function and some other code
> > are only required #ifdef MODULE.
> 
> Your patch is correct but it is wrong. ;)
> 
> #ifdefs around isp16_init() need to be removed as
> otherwise this driver is not initialized in built-in case.

It's somehow initialized via isp16_setup.

> Bartlomiej

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

