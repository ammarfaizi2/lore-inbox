Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261792AbVCYUie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbVCYUie (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 15:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbVCYUi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 15:38:29 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:52747 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261242AbVCYUiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 15:38:21 -0500
Date: Fri, 25 Mar 2005 21:38:20 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Roland Dreier <roland@topspin.com>
Cc: jgarzik@pobox.com, linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: drivers/net/at1700.c: at1700_probe1: array overflow
Message-ID: <20050325203820.GF3153@stusta.de>
References: <20050325181836.GB3153@stusta.de> <528y4b7ekc.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <528y4b7ekc.fsf@topspin.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2005 at 10:42:11AM -0800, Roland Dreier wrote:
>     Adrian> This can result in indexing in an array with 8 entries the
>     Adrian> 10th entry.
> 
> Well, not really, since the first 8 entries of the array have every
> 3-bit pattern.  So pos3 & 0x07 will always match one of them.
> 
> I agree it would be cleaner to make the loop only go up to 7 though.

You either have this (impossible) overflow, or the case l_i == 7 isn't 
tested explicitely.

I'd say simply leave it as it is now.

But if noone disagrees, I'm inclined to add a comment.

>  - R.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

