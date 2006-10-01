Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbWJASgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbWJASgO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 14:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbWJASgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 14:36:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17027 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750806AbWJASgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 14:36:13 -0400
Date: Sun, 1 Oct 2006 11:36:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: lkml <linux-kernel@vger.kernel.org>, torvalds@osdl.org, rossb@google.com,
       akpm@google.com, sam@ravnborg.org
Subject: Re: [patch 024/144] allow /proc/config.gz to be built as a module
Message-Id: <20061001113600.3c318eda.akpm@osdl.org>
In-Reply-To: <20061001093954.8d2aa064.rdunlap@xenotime.net>
References: <200610010627.k916RPIs010370@shell0.pdx.osdl.net>
	<20061001093954.8d2aa064.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Oct 2006 09:39:54 -0700
Randy Dunlap <rdunlap@xenotime.net> wrote:

> On Sat, 30 Sep 2006 23:27:25 -0700 akpm@osdl.org wrote:
> 
> > From: Ross Biro <rossb@google.com>
> > 
> > The driver for /proc/config.gz consumes rather a lot of memory and it is in
> > fact possible to build it as a module.
> > 
> > In some ways this is a bit risky, because the .config which is used for
> > compiling kernel/configs.c isn't necessarily the same as the .config which was
> > used to build vmlinux.
> > 
> > But OTOH the potential memory savings are decent, and it'd be fairly dumb to
> > build your configs.o with a different .config.
> 
> so after getting several disagreements on this, you are going ahead
> with it.

Actually I had this mentally tagged as "needs more arguing before merging"
but then forgot and went and sent it anyway.

So now it's in the "needs more arguing before we revert it" category.
