Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263168AbUCSXub (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 18:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbUCSXub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 18:50:31 -0500
Received: from ozlabs.org ([203.10.76.45]:1170 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263168AbUCSXu0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 18:50:26 -0500
Subject: Re: module scanning in kgdb 2.x
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <200403192036.04225.amitkale@emsyssoft.com>
References: <200403121206.16130.amitkale@emsyssoft.com>
	 <1079471931.19722.15.camel@bach>
	 <200403192036.04225.amitkale@emsyssoft.com>
Content-Type: text/plain
Message-Id: <1079740141.6883.12.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 20 Mar 2004 10:49:01 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-03-20 at 02:06, Amit S. Kale wrote:
> On Wednesday 17 Mar 2004 2:48 am, Rusty Russell wrote:
> > Why not just set the section strings to SHF_ALLOC rather than copying
> > (and possibly truncating) the names into your struct mod_section?
> > struct mod_section is then simply void *addr; char *name;
> 
> How can I do that? Do I have to use objcopy on module files for this purpose?

That'd be one way.  But I was thinking you should add it in the loading
code the way CONFIG_KALLSYMS does for some other sections.

Cheers,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

