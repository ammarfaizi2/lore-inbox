Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbWDBAGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbWDBAGH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 19:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbWDBAGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 19:06:07 -0500
Received: from xenotime.net ([66.160.160.81]:19375 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932319AbWDBAGF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 19:06:05 -0500
Date: Sat, 1 Apr 2006 16:08:18 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH -mm] acpi: fix memory_hotplug externs
Message-Id: <20060401160818.b9777586.rdunlap@xenotime.net>
In-Reply-To: <20060401221641.GC11800@stusta.de>
References: <20060328114655.05e1933f.rdunlap@xenotime.net>
	<20060401221641.GC11800@stusta.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Apr 2006 00:16:41 +0200 Adrian Bunk wrote:

> On Tue, Mar 28, 2006 at 11:46:55AM -0800, Randy.Dunlap wrote:
> > From: Randy Dunlap <rdunlap@xenotime.net>
> > 
> > Spell CONFIG option correctly so that externs work.
> > Fixes these warnings:
> > drivers/acpi/acpi_memhotplug.c:248: warning: implicit declaration of function 'add_memory'
> > drivers/acpi/acpi_memhotplug.c:312: warning: implicit declaration of function 'remove_memory'
> > 
> > Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> > ---
> >  linsrc/linux-2616-mm2/include/linux/memory_hotplug.h |    2 +-
> >  1 files changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- rddunlap.orig/linsrc/linux-2616-mm2/include/linux/memory_hotplug.h
> > +++ rddunlap/linsrc/linux-2616-mm2/include/linux/memory_hotplug.h
> > @@ -105,7 +105,7 @@ static inline int __remove_pages(struct 
> >  }
> >  
> >  #if defined(CONFIG_MEMORY_HOTPLUG) || defined(CONFIG_ACPI_HOTPLUG_MEMORY) \
> > -	|| defined(CONFIG_ACPI_MEMORY_HOTPLUG_MODULE)
> > +	|| defined(CONFIG_ACPI_HOTPLUG_MEMORY_MODULE)
> >  extern int add_memory(u64 start, u64 size);
> >  extern int remove_memory(u64 start, u64 size);
> >  #endif
> 
> What about simply offering the prototypes unconditionally?

duh, yes, that should be OK AFAIK.  Could you do that?

---
~Randy
