Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261807AbTCQRAo>; Mon, 17 Mar 2003 12:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261809AbTCQRAo>; Mon, 17 Mar 2003 12:00:44 -0500
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:16369 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id <S261807AbTCQRAn>;
	Mon, 17 Mar 2003 12:00:43 -0500
Date: Mon, 17 Mar 2003 18:12:46 +0100
From: wind-lkml@cocodriloo.com
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: riel@surriel.com, akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4 vm, program load, page faulting, ...
Message-ID: <20030317171246.GB11526@wind.cocodriloo.com>
References: <20030317151004.GR20188@holomorphy.com> <Pine.LNX.4.44.0303171100300.2571-100000@chimarrao.boston.redhat.com> <20030317165223.GA11526@wind.cocodriloo.com> <m3hea2gcoz.fsf@lexa.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3hea2gcoz.fsf@lexa.home.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 17, 2003 at 07:50:04PM +0300, Alex Tomas wrote:
> >>>>> wind  (w) writes:
> 
>  w> On Mon, Mar 17, 2003 at 11:01:31AM -0500, Rik van Riel wrote:
>  >> On Mon, 17 Mar 2003, William Lee Irwin III wrote:
>  >> > On Sat, 15 Mar 2003, Paul Albrecht wrote:
>  >> > >> ... Why does the kernel page fault on text pages, present in
>  >> the page > >> cache, when a program starts? Couldn't the pte's for
>  >> text present in the > >> page cache be resolved when they're
>  >> mapped to memory?
>  >> > 
> 
>  w> You should ask Andrew about his patch to do exactly that: he
>  w> forced all PROC_EXEC mmaps to be nonlinear-mapped and this forced
>  w> all programs to suck entire binaries into memory...  I recall he
>  w> saw at least 25% improvement at launching gnome.
> 
> they talked about pages _already present_ in pagecache.

I wonder if this could be done by walking and faulting
all pages at fs/binfmt_elf.c::elf_map just after do_mmap...
will try it just now :)
