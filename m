Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263187AbTCYS2J>; Tue, 25 Mar 2003 13:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263245AbTCYS2J>; Tue, 25 Mar 2003 13:28:09 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:35247 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263187AbTCYS1x>;
	Tue, 25 Mar 2003 13:27:53 -0500
Date: Tue, 25 Mar 2003 19:29:16 +0100
From: Jens Axboe <axboe@suse.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Randy.Dunlap" <randy.dunlap@verizon.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>, leo@netlabs.net
Subject: Re: [PATCH] reduce stack in cdrom/optcd.c
Message-ID: <20030325182916.GI30908@suse.de>
References: <3E7C0808.75B95FB7@verizon.net> <1048365798.9221.35.camel@irongate.swansea.linux.org.uk> <1048364399.1708.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048364399.1708.4.camel@laptop.fenrus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 22 2003, Arjan van de Ven wrote:
> On Sat, 2003-03-22 at 21:43, Alan Cox wrote:
> > On Sat, 2003-03-22 at 06:51, Randy.Dunlap wrote:
> > > Hi,
> > > 
> > > This reduces stack usage in drivers/cdrom/optcd.c by
> > > dynamically allocating a large (> 2 KB) buffer.
> > > 
> > > Patch is to 2.5.65.  Please apply.
> > 
> > This loosk broken. You are using GFP_KERNEL memory allocations on the
> > read path of a block device. What happens if the allocation fails 
> > because we need memory
> 
> it's unlikely that you have your swap on the cdrom ;)

your swap device could still be plugged behind your cdrom.

-- 
Jens Axboe

