Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbVK0Swz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbVK0Swz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 13:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbVK0Swz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 13:52:55 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:62984 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750735AbVK0Swy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 13:52:54 -0500
Date: Sun, 27 Nov 2005 19:52:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       markus.lidel@shadowconnect.com, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Mark Salyzyn <mark_salyzyn@adaptec.com>
Subject: Re: [patch] drivers/scsi/dpt_i2o.c: fix a NULL pointer dereference
Message-ID: <20051127185252.GG3988@stusta.de>
References: <20051126233637.GC3988@stusta.de> <20051127124738.GC13581@logos.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051127124738.GC13581@logos.cnet>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 27, 2005 at 10:47:38AM -0200, Marcelo Tosatti wrote:
> On Sun, Nov 27, 2005 at 12:36:37AM +0100, Adrian Bunk wrote:
> > The Coverity checker spotted this obvious NULL pointer dereference.
> 
> Hi Adrian,

Hi Marcelo,

> Could you explain why you remove the adpt_post_wait_lock acquision? 
> 
> And if it does not belong there, why don't you remove it instead of
> commeting out?
>...

my patch does remove the following not required line:

> > -	p2 = NULL;

It does not touch the following line that was already commented out:

> >  //	spin_lock_irqsave(&adpt_post_wait_lock, flags);
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

