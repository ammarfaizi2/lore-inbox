Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261818AbTCQStV>; Mon, 17 Mar 2003 13:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261822AbTCQStV>; Mon, 17 Mar 2003 13:49:21 -0500
Received: from [80.190.48.67] ([80.190.48.67]:18695 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id <S261818AbTCQStU> convert rfc822-to-8bit; Mon, 17 Mar 2003 13:49:20 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: wind-lkml@cocodriloo.com, Alex Tomas <bzzz@tmi.comex.ru>
Subject: Re: 2.4 vm, program load, page faulting, ...
Date: Mon, 17 Mar 2003 19:57:49 +0100
User-Agent: KMail/1.4.3
Cc: riel@surriel.com, akpm@digeo.com, linux-kernel@vger.kernel.org
References: <20030317151004.GR20188@holomorphy.com> <20030317171246.GB11526@wind.cocodriloo.com> <20030317173851.GC11526@wind.cocodriloo.com>
In-Reply-To: <20030317173851.GC11526@wind.cocodriloo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200303171957.49233.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 March 2003 18:38, wind-lkml@cocodriloo.com wrote:

Hi Wind,

> > I wonder if this could be done by walking and faulting
> > all pages at fs/binfmt_elf.c::elf_map just after do_mmap...
> > will try it just now :)
>
> OK, this is not tested, since I'm compiling it now... feel free
> to correct :)

mm/mmap.c:

unsigned long do_mmap_pgoff(struct file * file, unsigned long addr, unsigned 
long len,
        unsigned long prot, unsigned long flags, unsigned long pgoff)
{

your "do_mmap_pgoff" calls 7 arguments. Obviously it cannot compile 8-)

ciao, Marc
