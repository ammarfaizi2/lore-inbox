Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbUBKFae (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 00:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263544AbUBKFae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 00:30:34 -0500
Received: from ns.suse.de ([195.135.220.2]:23244 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263107AbUBKFad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 00:30:33 -0500
Date: Fri, 13 Feb 2004 20:42:27 +0100
From: Andi Kleen <ak@suse.de>
To: George Anzinger <george@mvista.com>
Cc: amitkale@emsyssoft.com, akpm@osdl.org, pavel@ucw.cz,
       linux-kernel@vger.kernel.org, piggy@timesys.com,
       trini@kernel.crashing.org
Subject: Re: kgdb support in vanilla 2.6.2
Message-Id: <20040213204227.0db612f7.ak@suse.de>
In-Reply-To: <40295388.5080901@mvista.com>
References: <20040204230133.GA8702@elf.ucw.cz.suse.lists.linux.kernel>
	<20040204155452.49c1eba8.akpm@osdl.org.suse.lists.linux.kernel>
	<p73n07ykyop.fsf@verdi.suse.de>
	<200402052320.04393.amitkale@emsyssoft.com>
	<20040206032054.3fd7db8d.ak@suse.de>
	<40295388.5080901@mvista.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Feb 2004 13:56:24 -0800
George Anzinger <george@mvista.com> wrote:

> > Problem is that he did it without binutils support. I don't think that's a good
> > idea because it makes the code basically unmaintainable for normal souls
> > (it's like writing assembly code directly in hex) 
> 
> Well, bin utils, at this time, makes it even worse in that it does not support 
> the expression syntax.  Also, it is not asm but dwarf2 and it is written in, 
> IMHO, useful macros (not hex :)

The latest binutils should support .cfi_* for i386 too. I don't see much sense
in making the code more ugly just for staying backwards compatible with older versions for the 
debug case (without CONFIG_DEBUG_INFO it should be compatible though).
You need a fairly new gdb too anyways for it.

-Andi
