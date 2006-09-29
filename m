Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161136AbWI2QXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161136AbWI2QXa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 12:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161135AbWI2QXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 12:23:30 -0400
Received: from xenotime.net ([66.160.160.81]:46476 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161127AbWI2QX2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 12:23:28 -0400
Date: Fri, 29 Sep 2006 09:24:46 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       76306.1226@compuserve.com, ebiederm@xmission.com
Subject: Re: [PATCH] fix EMBEDDED + SYSCTL menu
Message-Id: <20060929092446.6e2227b4.rdunlap@xenotime.net>
In-Reply-To: <20060929160521.GF3469@stusta.de>
References: <20060928204251.a20470c5.rdunlap@xenotime.net>
	<20060929160521.GF3469@stusta.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006 18:05:21 +0200 Adrian Bunk wrote:

> On Thu, Sep 28, 2006 at 08:42:51PM -0700, Randy Dunlap wrote:
> > From: Randy Dunlap <rdunlap@xenotime.net>
> > 
> > SYSCTL should still depend on EMBEDDED.  This unbreaks the
> > EMBEDDED menu (from the recent SYSCTL_SYCALL menu option patch).
> > 
> > Fix typos in new SYSCTL_SYSCALL menu.
> > 
> > Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> > ---
> >  init/Kconfig |   14 +++++++-------
> >  1 files changed, 7 insertions(+), 7 deletions(-)
> > 
> > --- linux-2618-g10.orig/init/Kconfig
> > +++ linux-2618-g10/init/Kconfig
> > @@ -257,6 +257,9 @@ config CC_OPTIMIZE_FOR_SIZE
> >  
> >  	  If unsure, say N.
> >  
> > +config SYSCTL
> > +	bool
> > +
> >  menuconfig EMBEDDED
> >  	bool "Configure standard kernel features (for small systems)"
> >  	help
> > @@ -272,11 +275,8 @@ config UID16
> >  	help
> >  	  This enables the legacy 16-bit UID syscall wrappers.
> >  
> > -config SYSCTL
> > -	bool
> > -
> 
> ACK
> 
> >  config SYSCTL_SYSCALL
> > -	bool "Sysctl syscall support"
> > +	bool "Sysctl syscall support" if EMBEDDED
> >  	default n
> >  	select SYSCTL
> >  	---help---
> >...
> 
> You could achieve the same by removing the option...
> 
> Simply move SYSCTL_SYSCALL to the same place you are moving SYSCTL to 
> without fiddling with the dependencies.

Yes, I realize that (I even had that patch earlier).
I don't care which way it's done.  Eric, any preference here?

---
~Randy
