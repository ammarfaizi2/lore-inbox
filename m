Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318188AbSGaMqh>; Wed, 31 Jul 2002 08:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318212AbSGaMqh>; Wed, 31 Jul 2002 08:46:37 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:60423 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318188AbSGaMqg>; Wed, 31 Jul 2002 08:46:36 -0400
Date: Wed, 31 Jul 2002 09:49:46 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: akpm@zip.com.au, <linux-kernel@vger.kernel.org>
Subject: Re: BUG at rmap.c:212
In-Reply-To: <AA4A1044BB@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.44L.0207310948150.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2002, Petr Vandrovec wrote:

>   yesterday I told (in IDE thread) that BUG at rmap.c:212 is probably
> already fixed by changeset 520. Unfortunately, it is not, I got it again
> with BK tree. It happened again when 'ntpd' called exit() upon receiving
> sigterm.

Line 212 is   'pte_chain_unlock(page);'   right ?

What configuration are you running ?  SMP ?  PREEMPT ?  What compiler ?

>   Stack trace:
>
>   page_remove_rmap
>   zap_pte_range
>   zap_pmd_range
>   unmap_page_range
>   exit_mmap
>   mmput
>   do_exit
>   sys_exit
>   syscall_call
>
> If it is not known bug, I'll rebuild kernel with DEBUG_RMAP.
> Unfortunately it looks like that machine must have uptime > 12hrs to
> trigger this. Probably updatedb or some other task must be run to try to
> swap ntpd out?

It is not a known bug. In fact I've never seen this one before.

kind regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

