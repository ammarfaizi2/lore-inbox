Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261884AbTCQSyd>; Mon, 17 Mar 2003 13:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261877AbTCQSyd>; Mon, 17 Mar 2003 13:54:33 -0500
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:1261 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id <S261884AbTCQSyc>;
	Mon, 17 Mar 2003 13:54:32 -0500
Date: Mon, 17 Mar 2003 20:06:36 +0100
From: wind-lkml@cocodriloo.com
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: wind-lkml@cocodriloo.com, Alex Tomas <bzzz@tmi.comex.ru>, riel@surriel.com,
       akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4 vm, program load, page faulting, ...
Message-ID: <20030317190636.GD11526@wind.cocodriloo.com>
References: <20030317151004.GR20188@holomorphy.com> <20030317171246.GB11526@wind.cocodriloo.com> <20030317173851.GC11526@wind.cocodriloo.com> <200303171957.49233.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303171957.49233.m.c.p@wolk-project.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 17, 2003 at 07:57:49PM +0100, Marc-Christian Petersen wrote:
> On Monday 17 March 2003 18:38, wind-lkml@cocodriloo.com wrote:
> 
> Hi Wind,
> 
> > > I wonder if this could be done by walking and faulting
> > > all pages at fs/binfmt_elf.c::elf_map just after do_mmap...
> > > will try it just now :)
> >
> > OK, this is not tested, since I'm compiling it now... feel free
> > to correct :)
> 
> mm/mmap.c:
> 
> unsigned long do_mmap_pgoff(struct file * file, unsigned long addr, unsigned 
> long len,
>         unsigned long prot, unsigned long flags, unsigned long pgoff)
> {
> 
> your "do_mmap_pgoff" calls 7 arguments. Obviously it cannot compile 8-)
> 

My first patch, I'm just becoming intimate with printk ;)

