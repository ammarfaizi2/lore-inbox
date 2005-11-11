Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbVKKEBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbVKKEBJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 23:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbVKKEBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 23:01:09 -0500
Received: from xenotime.net ([66.160.160.81]:61656 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932336AbVKKEBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 23:01:08 -0500
Date: Thu, 10 Nov 2005 19:45:58 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andrew Morton <akpm@osdl.org>
Cc: bunk@stusta.de, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add -Werror-implicit-function-declaration to CFLAGS
Message-Id: <20051110194558.4f7f8cd0.rdunlap@xenotime.net>
In-Reply-To: <20051110182443.514622ed.akpm@osdl.org>
References: <20051107200336.GH3847@stusta.de>
	<20051110042857.38b4635b.akpm@osdl.org>
	<20051111021258.GK5376@stusta.de>
	<20051110182443.514622ed.akpm@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2005 18:24:43 -0800 Andrew Morton wrote:

> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > On Thu, Nov 10, 2005 at 04:28:57AM -0800, Andrew Morton wrote:
> > > Adrian Bunk <bunk@stusta.de> wrote:
> > > >
> > > > Currently, using an undeclared function gives a compile warning, but it 
> > > >  can lead to a nasty runtime error if the prototype of the function is 
> > > >  different from what gcc guessed.
> > > > 
> > > >  With -Werror-implicit-function-declaration, we are getting an immediate 
> > > >  compile error instead.
> > > > 
> > > >  There will be some compile errors in cases where compilation previously
> > > >  worked because the undefined function wasn't called due to gcc dead code
> > > >  elimination, but in these cases a proper fix doesnt harm.
> > > > 
> > > 
> > > Sorry, I need to build allmodconfig kernels on wacky architectures (eg
> > > ppc64) and this patch is killing me.
> > 
> > Can you send me the list of compile errors so that I can work on fixing 
> > them?
> > 
> 
> No handily, sorry.   Missing virt_to_bus() is the typical problem.
> 
> The cross-tools at http://developer.osdl.org/dev/plm/cross_compile/ are
> quite simple to install.

Ack that.  Those are the ones I use.

---
~Randy
