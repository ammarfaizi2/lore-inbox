Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262506AbUCCQGg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 11:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262516AbUCCQGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 11:06:36 -0500
Received: from fed1mtao02.cox.net ([68.6.19.243]:22933 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S262506AbUCCQGe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 11:06:34 -0500
Date: Wed, 3 Mar 2004 09:06:33 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: George Anzinger <george@mvista.com>, Andrew Morton <akpm@osdl.org>,
       ak@suse.de, pavel@ucw.cz, linux-kernel@vger.kernel.org,
       piggy@timesys.com
Subject: Re: kgdb support in vanilla 2.6.2
Message-ID: <20040303160633.GU20227@smtp.west.cox.net>
References: <20040204230133.GA8702@elf.ucw.cz.suse.lists.linux.kernel> <20040302132751.255b9807.akpm@osdl.org> <40451E50.4080806@mvista.com> <200403031038.39339.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403031038.39339.amitkale@emsyssoft.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 10:38:39AM +0530, Amit S. Kale wrote:
> On Wednesday 03 Mar 2004 5:22 am, George Anzinger wrote:
> > Andrew Morton wrote:
> > > George Anzinger <george@mvista.com> wrote:
> > >> Often it is not clear just why we are in the stub, given that
> > >>we trap such things as kernel page faults, NMI watchdog, BUG macros and
> > >> such.
> > >
> > > Yes, that can be confusing.  A little printk on the console prior to
> > > entering the debugger would be nice.
> >
> > That assumes that one can do a printk and not run into a lock.  Far better
> > IMNSHO is to provide a simple way to get it from gdb.  One can then even
> > provide a gdb macro to print the relevant source line and its surrounds.  I
> > my lighter moments I call this the comefrom macro :)  In my kgdb it would
> > look like:
> >
> > l * kgdb_info.called_from
> 
> How about echoing "Waiting for gdb connection" stright into the serial line 
> without any encoding? Since gdb won't be connected to the other end, and many 
> a times a minicom could be running at the other end, it'll give a user an 
> indication of kgdb being ready.

It's not "GDB is ready" it's "GDB is ready now because ..."

-- 
Tom Rini
http://gate.crashing.org/~trini/
