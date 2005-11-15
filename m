Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbVKOPJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbVKOPJh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 10:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbVKOPJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 10:09:37 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:45511 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932402AbVKOPJg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 10:09:36 -0500
Date: Tue, 15 Nov 2005 10:09:32 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Keith Owens <kaos@sgi.com>
cc: linux-kernel@vger.kernel.org, Stephen Hemminger <shemminger@osdl.org>,
       Andi Kleen <ak@suse.de>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: Re: [Patch 2.6.15-rc1] Clean up the die notifier registration routines
In-Reply-To: <12454.1132027138@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.44L0.0511151007560.4851-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Nov 2005, Keith Owens wrote:

> Remove the extraneous die_notifier_lock, notifier_chain_register()
> and notifier_chain_unregister already take a lock.  Also there is some
> work being done to make the generic notify code race safe and the
> die_notifier_lock would get in that way of that rework.  See
> http://marc.theaimsgroup.com/?l=linux-kernel&m=113175279131346&w=2
> 
> Add unregister_die_notifier() and export it on all architectures.
> 
> Export register_die_notifier() on some architectures, others already
> had an export.
> 
> Correct include/asm-*/kdebug.h to define the functions as extern.
> 
> Remove trailing whitespace in include/asm-x86_64/kdebug.h.
> 
> Compile tested on i386 and x86_64, powerpc and sparc64 have only been
> desk checked.  The ia64 version of this code has already been changed
> in 2.6.15-rc1.

Keith, can you delay this patch until the general notifier fixups have
been merged?  Most of what you did duplicates changes that we are making
and some of it will clash.

Alan Stern

