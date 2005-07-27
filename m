Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbVG0E7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVG0E7J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 00:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbVG0E7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 00:59:09 -0400
Received: from smtp105.sbc.mail.mud.yahoo.com ([68.142.198.204]:18026 "HELO
	smtp105.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261263AbVG0E7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 00:59:08 -0400
Date: Tue, 26 Jul 2005 21:59:01 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: define-auxiliary-vector-size-at_vector_size.patch added to -mm tree
Message-ID: <20050727045901.GA11392@lucon.org>
References: <200507262144.j6QLiJVC015284@shell0.pdx.osdl.net> <20050727002608.GA7469@lucon.org> <20050726215323.0070c867.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050726215323.0070c867.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2005 at 09:53:23PM -0700, Andrew Morton wrote:
> "H. J. Lu" <hjl@lucon.org> wrote:
> >
> > My patch breaks x86_64 build. This patch will fix x86_64 build. I am
> >  also enclosing the updated full patch.
> 
> It now breaks ppc64
> 
> include/asm/elf.h: In function `dump_task_regs':
> include/asm/elf.h:177: error: dereferencing pointer to incomplete type
> 
> That's because pt_regs isn't known, because sched.h is including elf.h
> before pt_regs gets defined.  This is a pretty fragile area I'm afraid.

Should we creat a new header file like auxvector.h? Auxiliary isn't
ELF specific anyway.


H.J.
