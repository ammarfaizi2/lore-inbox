Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262863AbTEMEux (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 00:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbTEMEux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 00:50:53 -0400
Received: from ns.suse.de ([213.95.15.193]:6412 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262863AbTEMEuw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 00:50:52 -0400
Date: Tue, 13 May 2003 07:03:36 +0200
From: Andi Kleen <ak@suse.de>
To: linux-kernel@vger.kernel.org, hch@infradead.org, gregkh@kroah.com,
       linux-security-module@wirex.com, ak@suse.de
Subject: Re: [PATCH] Early init for security modules
Message-ID: <20030513050336.GA10596@Wotan.suse.de>
References: <20030512200309.C20068@figure1.int.wirex.com> <20030512201518.X19432@figure1.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030512201518.X19432@figure1.int.wirex.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 08:15:18PM -0700, Chris Wright wrote:
> * Chris Wright (chris@wirex.com) wrote:
> > As discussed before, here is a simple patch to allow for early
> > initialization of security modules when compiled statically into the
> > kernel.  The standard do_initcalls is too late for complete coverage of
> > all filesystems and threads for example.  If this looks OK, I'd like to
> > push it on to Linus.  Patch is against 2.5.69-bk.  It is tested on i386,
> > and various arch maintainers are copied on relevant bits of patch.
> 
> This is just the arch specific linker bits for the early initialization
> for security modules patch.  Does this look sane for this arch?

It would work for x86-64. But why can't you use core_initcall() or 
postcore_initcall() ? 

-Andi
