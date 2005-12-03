Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbVLCSGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbVLCSGY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 13:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbVLCSGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 13:06:24 -0500
Received: from cantor2.suse.de ([195.135.220.15]:48847 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932114AbVLCSGY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 13:06:24 -0500
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Vinay Venkataraghavan <raghavanvinay@yahoo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: copy_from_user/copy_to_user question
References: <5fv0G-3kS-11@gated-at.bofh.it> <5fvam-3vP-9@gated-at.bofh.it>
	<43910731.4090404@shaw.ca>
	<1133580225.4894.29.camel@localhost.localdomain>
From: Andi Kleen <ak@suse.de>
Date: 03 Dec 2005 15:35:37 -0700
In-Reply-To: <1133580225.4894.29.camel@localhost.localdomain>
Message-ID: <p73hd9p4xmu.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:
> 
> Nope, the kernel is always locked into memory.  If you take a page fault
> from the kernel world, you will crash and burn. The kernel is never
> "swapped out".  So if you are in kernel mode, going into do_page_fault
> in arch/i386/mm/fault.c there is no path to swap a page in.

Actually there is - when the page fault was caused by *_user. 

-Andi
