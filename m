Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267499AbUBSTkd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 14:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267506AbUBSTkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 14:40:33 -0500
Received: from ns.suse.de ([195.135.220.2]:35540 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267499AbUBSTk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 14:40:28 -0500
Date: Fri, 20 Feb 2004 17:44:54 +0100
From: Andi Kleen <ak@suse.de>
To: Jakub Jelinek <jakub@redhat.com>
Cc: tony@atomide.com, linux-kernel@vger.kernel.org
Subject: Re: Intel x86-64 support patch breaks amd64
Message-Id: <20040220174454.77ec7086.ak@suse.de>
In-Reply-To: <20040219193606.GC31589@devserv.devel.redhat.com>
References: <20040219183448.GB8960@atomide.com>
	<20040220171337.10cd1ae8.ak@suse.de>
	<20040219193606.GC31589@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Feb 2004 14:36:10 -0500
Jakub Jelinek <jakub@redhat.com> wrote:

> On Fri, Feb 20, 2004 at 05:13:37PM +0100, Andi Kleen wrote:
> > --- linux-2.6.3/arch/x86_64/kernel/x8664_ksyms.c-o	2004-02-19 09:01:09.000000000 +0100
> > +++ linux-2.6.3/arch/x86_64/kernel/x8664_ksyms.c	2004-02-19 09:08:04.000000000 +0100
> > @@ -194,7 +194,9 @@
> >  
> >  EXPORT_SYMBOL(die_chain);
> >  
> > +#ifdef CONFIG_SMP_
> 
> 		    ^ Isn't this a typo?

Indeed. Thanks for catching it.

It probably doesn't hurt because I don't know of any module that uses cpu_sibling_map[].
I think I just copied the export from i386. Maybe it would be best to just remove it completely.

-Andi
