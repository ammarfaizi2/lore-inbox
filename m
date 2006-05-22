Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbWEVNCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWEVNCe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 09:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWEVNCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 09:02:34 -0400
Received: from nevyn.them.org ([66.93.172.17]:8143 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S1750803AbWEVNCe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 09:02:34 -0400
Date: Mon, 22 May 2006 09:02:22 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Renzo Davoli <renzo@cs.unibo.it>
Cc: Jeff Dike <jdike@addtoit.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andi Kleen <ak@suse.de>, Ulrich Drepper <drepper@gmail.com>,
       osd@cs.unibo.it, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2-ptrace_multi
Message-ID: <20060522130222.GA16937@nevyn.them.org>
Mail-Followup-To: Renzo Davoli <renzo@cs.unibo.it>,
	Jeff Dike <jdike@addtoit.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Andi Kleen <ak@suse.de>, Ulrich Drepper <drepper@gmail.com>,
	osd@cs.unibo.it, linux-kernel@vger.kernel.org
References: <20060518155337.GA17498@cs.unibo.it> <20060519174534.GA22346@cs.unibo.it> <20060519201509.GA13477@nevyn.them.org> <200605192217.30518.ak@suse.de> <1148135825.2085.33.camel@localhost.localdomain> <20060520183020.GC11648@cs.unibo.it> <20060520213959.GA4229@ccure.user-mode-linux.org> <20060521152810.GL15497@cs.unibo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060521152810.GL15497@cs.unibo.it>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2006 at 05:28:10PM +0200, Renzo Davoli wrote:
> It is not enough. I am fixing the [GS]ETREGS for ppc32 but it happens
> that the error number is stored in the register PT_CCR (a.k.a. R38)
> so I need an extra call to get that, then I need the program counter which is
> in PT_NIP (R31). [GS]ETREGS for ppc load/store just the range R0-R31.
> so I need 3 syscalls for each syscall issued by the ptraced process
> instead of just one.

Then have you considered changing the regset returned to be actually
useful?  Especially for ppc32 where you say it was not previously
implemented?

-- 
Daniel Jacobowitz
CodeSourcery
