Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbUBYRuj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 12:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbUBYRui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 12:50:38 -0500
Received: from fed1mtao04.cox.net ([68.6.19.241]:45981 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S261539AbUBYRuF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 12:50:05 -0500
Date: Wed, 25 Feb 2004 10:50:04 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/6] A different KGDB stub
Message-ID: <20040225175004.GS1052@smtp.west.cox.net>
References: <20040217220249.GB16881@smtp.west.cox.net> <20040217155036.33e37c67.akpm@osdl.org> <20040218000315.GN16881@smtp.west.cox.net> <20040217163312.729c951f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040217163312.729c951f.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 17, 2004 at 04:33:12PM -0800, Andrew Morton wrote:

> Tom Rini <trini@kernel.crashing.org> wrote:
> >
> > By my read of Andi's email, the kern_do_schedule() gunk is "I really
> > don't like this change. It is completely useless because you can get the
> > pt_regs as well from the stack.  Please don't add it. George's stub also
> > didn't need it."
> > 
> > But I don't see how it does.  But I'll look again tomorrow.
> 
> OK, thanks.  That would be appreciated, if only because the sched.c and
> entry.S changes have caused significant patch-conflict hassles in the past,
> and they're pretty ugly.

Two things:
- I've looked harder, and I still don't see some pre-exiting get pt_regs
  off the stack func / macro.  But it would probably be generally useful
  since it _looks_ like there's few places it could be used.  Or maybe I
  misread something and just missed it (not being an i386 person, it's
  possible :))
- The current plan for KGDB stuffs is to punt on the thread stuffs for
  now anyhow, so we can look at this again later.

-- 
Tom Rini
http://gate.crashing.org/~trini/
