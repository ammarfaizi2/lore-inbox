Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267257AbUBSVEb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 16:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267305AbUBSVEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 16:04:31 -0500
Received: from ns.suse.de ([195.135.220.2]:40595 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267257AbUBSVEV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 16:04:21 -0500
Date: Fri, 20 Feb 2004 20:32:28 +0100
From: Andi Kleen <ak@suse.de>
To: Philippe Elie <phil.el@wanadoo.fr>
Cc: jakub@redhat.com, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] Fix typo in x86-64 fix
Message-Id: <20040220203228.7846bf32.ak@suse.de>
In-Reply-To: <20040219212002.GC382@zaniah>
References: <20040219183448.GB8960@atomide.com>
	<20040220171337.10cd1ae8.ak@suse.de>
	<20040219193606.GC31589@devserv.devel.redhat.com>
	<20040220174454.77ec7086.ak@suse.de>
	<20040219212002.GC382@zaniah>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Feb 2004 21:20:02 +0000
Philippe Elie <phil.el@wanadoo.fr> wrote:

> On Fri, 20 Feb 2004 at 17:44 +0000, Andi Kleen wrote:
> 
> > > > +#ifdef CONFIG_SMP_
> > > 
> > > 		    ^ Isn't this a typo?
> > 
> > Indeed. Thanks for catching it.
> > 
> > It probably doesn't hurt because I don't know of any module that uses cpu_sibling_map[].
> > I think I just copied the export from i386. Maybe it would be best to just remove it completely.
> 
> Andrew added it a few hours ago, oprofile use it.

Ok, Andrew, can you please apply this incremental patch to fix the typo too ? 

diff -u linux-2.6.3-amd64/arch/x86_64/kernel/x8664_ksyms.c-o linux-2.6.3-amd64/arch/x86_64/kernel/x8664_ksyms.c
--- linux-2.6.3-amd64/arch/x86_64/kernel/x8664_ksyms.c-o	2004-02-20 15:53:53.000000000 +0100
+++ linux-2.6.3-amd64/arch/x86_64/kernel/x8664_ksyms.c	2004-02-20 20:25:03.000000000 +0100
@@ -194,7 +194,7 @@
 
 EXPORT_SYMBOL(die_chain);
 
-#ifdef CONFIG_SMP_
+#ifdef CONFIG_SMP
 EXPORT_SYMBOL(cpu_sibling_map);
 #endif
 

-Andi
