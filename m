Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965121AbWEOS1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965121AbWEOS1b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 14:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965124AbWEOS1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 14:27:31 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:57216 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S965121AbWEOS1a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 14:27:30 -0400
Date: Mon, 15 May 2006 11:30:18 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       ian.pratt@xensource.com, Christian.Limpach@cl.cam.ac.uk
Subject: Re: [RFC PATCH 16/35] subarch support for interrupt and exception gates
Message-ID: <20060515183018.GW25010@moss.sous-sol.org>
References: <20060509084945.373541000@sous-sol.org> <20060509085154.441800000@sous-sol.org> <20060513052740.54d8cbff.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060513052740.54d8cbff.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> On Tue, 09 May 2006 00:00:16 -0700
> Chris Wright <chrisw@sous-sol.org> wrote:
> 
> > --- linus-2.6.orig/include/asm-i386/mach-xen/setup_arch_pre.h
> > +++ linus-2.6/include/asm-i386/mach-xen/setup_arch_pre.h
> > @@ -5,6 +5,8 @@
> >  struct start_info *xen_start_info;
> >  EXPORT_SYMBOL(xen_start_info);
> >  
> > +struct trap_info xen_trap_table[257];
> > +
> >  /*
> >   * Point at the empty zero page to start with. We map the real shared_info
> >   * page as soon as fixmap is up and running.
> 
> Is there any particular reason why things-which-should-be-in-a-C-file are
> present in a .h file?

It's following direction of current subarch interaction with setup.c
(namely the setup_arch_post.h).  It's definitely not so nice.
