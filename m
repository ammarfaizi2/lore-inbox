Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265467AbUAJWjG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 17:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265471AbUAJWjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 17:39:06 -0500
Received: from gaia.cela.pl ([213.134.162.11]:47880 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S265467AbUAJWjD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 17:39:03 -0500
Date: Sat, 10 Jan 2004 23:38:38 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: Valdis.Kletnieks@vt.edu, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] invalid ELF binaries can execute - better sanity
 checking 
In-Reply-To: <Pine.LNX.4.56.0401101431340.13547@jju_lnx.backbone.dif.dk>
Message-ID: <Pine.LNX.4.44.0401102336380.1739-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Do you need smaller than this?  :
...
> That's a 100% valid ELF executable, and the entire program is 91 bytes..
> Sure, it doesn't do much useful, and the ELF header and program header
> table is huge overhead compared to the actual program, but that overhead
> is minimal in any program that does any actual work.
> 
> Also, I'm not planning to add anything that disallows anything the ELF
> spec allows, so you can still pull funny tricks like have sections overlap
> and in the above program put _start inside the unused padding bytes in
> e_ident[EI_PAD] if you want.. still a valid program, and not something
> that the checks I'm adding will prevent.
> 
> It you want *really* tiny files then, as some have suggested, anothe
> format could be used.
> In my oppinion, if you claim to be an ELF executable, then you should be a
> *valid* ELF executable.. If you are not a valid elf file but claim to be
> so, then either something corrupted you or the tools that generated you
> are buggy - and you should not be allowed to even attempt to execute - for
> all the reasons I gave in my original mail.

OK, if that 91 is OK, then no problem, I was thinking the minimum would be 
around 1-2 KB (now that I think about it, not really sure why I assumed 
that).  I'm not mad enough to require/want shrinking from 90 to 45 
bytes :) especially since most useful programs have a little more meat to 
them than the 80 bytes worth of header :)

Cheers,
MaZe


