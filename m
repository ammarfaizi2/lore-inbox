Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317373AbSH0WyP>; Tue, 27 Aug 2002 18:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317393AbSH0WyP>; Tue, 27 Aug 2002 18:54:15 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:2812 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S317373AbSH0WyO>; Tue, 27 Aug 2002 18:54:14 -0400
Date: Tue, 27 Aug 2002 18:58:33 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Peter Chubb <peter@chubb.wattle.id.au>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: Large block device patch, part 1 of 9
Message-ID: <20020827185833.B26573@redhat.com>
References: <15717.52317.654149.636236@wombat.chubb.wattle.id.au> <20020823070759.GS19435@clusterfs.com> <20020827152303.L35@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020827152303.L35@toy.ucw.cz>; from pavel@suse.cz on Tue, Aug 27, 2002 at 03:23:04PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2002 at 03:23:04PM +0000, Pavel Machek wrote:
> Hi!
> 
> > Then the following works properly without ugly casts or warnings:
> > 
> > 	__u64 val = 1;
> > 
> > 	printk("at least "PFU64" of your u64s are belong to us\n", val);
> 
> Casts are ugly but this looks even worse. I'd go for casts.

Casts override the few type checking abilities the compiler gives us.  At 
least with the PFU64 style, we'll get warnings when someone changes a variable 
into a pointer without remembering to update the printk.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
