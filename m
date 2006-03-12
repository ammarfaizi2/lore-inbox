Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWCLNfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWCLNfc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 08:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWCLNfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 08:35:32 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:59660 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750830AbWCLNfb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 08:35:31 -0500
Date: Sun, 12 Mar 2006 14:35:14 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc6-mm1
Message-ID: <20060312133514.GA9922@mars.ravnborg.org>
References: <20060312031036.3a382581.akpm@osdl.org> <200603121416.26583.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603121416.26583.rjw@sisk.pl>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2006 at 02:16:26PM +0100, Rafael J. Wysocki wrote:
> On Sunday 12 March 2006 12:10, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc6/2.6.16-rc6-mm1/
> 
> Doesn't compile for me:
> 
> rafael@albercik:~/src/mm/linux-2.6.16-rc6-mm1> make
>   CHK     include/linux/version.h
>   SPLIT   include/linux/autoconf.h -> include/config/*
>   HOSTCC  scripts/genksyms/genksyms.o
> scripts/genksyms/genksyms.c:35:30: error: ../mod/elfconfig.h: No such file or directory
> scripts/genksyms/genksyms.c: In function ???export_symbol???:
> scripts/genksyms/genksyms.c:461: error: ???MODULE_SYMBOL_PREFIX??? undeclared (first use in this function)
> scripts/genksyms/genksyms.c:461: error: (Each undeclared identifier is reported only once
> scripts/genksyms/genksyms.c:461: error: for each function it appears in.)
> make[2]: *** [scripts/genksyms/genksyms.o] Error 1
> make[1]: *** [scripts/genksyms] Error 2
> make: *** [scripts] Error 2
My bad.
 
> #
> # Loadable module support
> #
> CONFIG_MODULES=y
> CONFIG_MODULE_UNLOAD=y
> CONFIG_MODULE_FORCE_UNLOAD=y
> CONFIG_MODVERSIONS=y
Use CONFIG_MODVERSIONS=n for now as workaround.

	Sam
