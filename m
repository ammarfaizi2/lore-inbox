Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262059AbSJITSs>; Wed, 9 Oct 2002 15:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262074AbSJITSs>; Wed, 9 Oct 2002 15:18:48 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:33009 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S262059AbSJITSr>; Wed, 9 Oct 2002 15:18:47 -0400
Date: Wed, 9 Oct 2002 12:16:15 -0700
From: Chris Wright <chris@wirex.com>
To: Tony Glader <Tony.Glader@blueberrysolutions.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: capable()-function
Message-ID: <20021009121615.B25392@figure1.int.wirex.com>
Mail-Followup-To: Tony Glader <Tony.Glader@blueberrysolutions.com>,
	linux-kernel@vger.kernel.org
References: <20021009120819.A25392@figure1.int.wirex.com> <Pine.LNX.4.44.0210092217320.785-100000@blueberrysolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0210092217320.785-100000@blueberrysolutions.com>; from Tony.Glader@blueberrysolutions.com on Wed, Oct 09, 2002 at 10:19:02PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Glader (Tony.Glader@blueberrysolutions.com) wrote:
> On Wed, 9 Oct 2002, Chris Wright wrote:
> 
> > > In this case capable() call has been made from a kernel module. I think a
> > The userspace task that called the ioctl() is the one to look at.
> 
> ...
> 
> > > CapInh: 0000000000000000
> > > CapPrm: 00000000fffffeff
> > > CapEff: 00000000fffffeff
> > 
> > Ok, I don't think the capable() check is failing.
> 
> So though me too, but now we are getting to the point - capable() check 
> fails! How that can be possible?

You could dump something like this before the capable() call:

printk(KERN_DEBUG "%s:(%d) eff: 0x%x\n", current->comm, current->pid,
						cap_t(current->cap_effective));
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
