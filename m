Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUCDAvD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 19:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbUCDAvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 19:51:03 -0500
Received: from ns.suse.de ([195.135.220.2]:48836 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261169AbUCDAu7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 19:50:59 -0500
Date: Thu, 4 Mar 2004 01:50:56 +0100
From: Andi Kleen <ak@suse.de>
To: George Anzinger <george@mvista.com>
Cc: akpm@osdl.org, amitkale@emsyssoft.com, pavel@ucw.cz,
       linux-kernel@vger.kernel.org, piggy@timesys.com,
       trini@kernel.crashing.org
Subject: Re: kgdb support in vanilla 2.6.2
Message-Id: <20040304015056.4d2cc3ee.ak@suse.de>
In-Reply-To: <40467BC3.7030708@mvista.com>
References: <20040204230133.GA8702@elf.ucw.cz.suse.lists.linux.kernel>
	<200402061914.38826.amitkale@emsyssoft.com>
	<403FDB37.2020704@mvista.com>
	<200403011508.23626.amitkale@emsyssoft.com>
	<4044F84D.4030003@mvista.com>
	<20040302132751.255b9807.akpm@osdl.org>
	<20040303100515.GB8008@wotan.suse.de>
	<40467BC3.7030708@mvista.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Mar 2004 16:43:47 -0800
George Anzinger <george@mvista.com> wrote:

> Andi Kleen wrote:
> > On Tue, Mar 02, 2004 at 01:27:51PM -0800, Andrew Morton wrote:
> > 
> >>George Anzinger <george@mvista.com> wrote:
> >>
> >>> Often it is not clear just why we are in the stub, given that 
> >>>we trap such things as kernel page faults, NMI watchdog, BUG macros and such.
> >>
> >>Yes, that can be confusing.  A little printk on the console prior to
> >>entering the debugger would be nice.
> > 
> > 
> > What I did for kdb and panic some time ago was to flash the keyboard
> > lights. If you use a unique frequency (different from kdb 
> > and from panic) it works quite nicely.
> 
> Assuming a key board and a clear (no spin locks) path to it.  Still it only says 

I think it's reasonable to just write to the keyboard without any locking.
The keyboard driver will recover.

> we are in kgdb, now why.

The big advantage is that it works even when you are in X (like most people) 
printks are often not visible.

-Andi
> 
