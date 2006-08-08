Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964997AbWHHQxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964997AbWHHQxa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 12:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbWHHQxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 12:53:30 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:40874 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S964997AbWHHQx3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 12:53:29 -0400
Subject: Re: 2.6.18-rc3-mm1: O= builds broken
From: Dave Hansen <haveblue@us.ibm.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Adrian Bunk <bunk@stusta.de>, Jeff Dike <jdike@addtoit.com>,
       "lkml@o2.pl / IMAP" <lkml@o2.pl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060807195912.GA14126@mars.ravnborg.org>
References: <20060806002400.694948a1.akpm@osdl.org>
	 <20060806082321.GZ25692@stusta.de>
	 <20060807195912.GA14126@mars.ravnborg.org>
Content-Type: text/plain
Date: Tue, 08 Aug 2006 09:33:43 -0700
Message-Id: <1155054823.19249.66.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-07 at 21:59 +0200, Sam Ravnborg wrote:
> On Sun, Aug 06, 2006 at 10:23:21AM +0200, Adrian Bunk wrote:
> > $ make O=/home/bunk/linux/kernel-2.6/out/full/ oldconfig
> >   HOSTCC  scripts/basic/fixdep
> >   HOSTCC  scripts/basic/docproc
> >   GEN     /home/bunk/linux/kernel-2.6/out/full/Makefile
> >   HOSTCC  scripts/kconfig/conf.o
> >   HOSTCC  scripts/kconfig/kxgettext.o
> >   HOSTCC  scripts/kconfig/lxdialog/checklist.o
> > /home/bunk/linux/kernel-2.6/linux-2.6.18-rc3-mm1/scripts/kconfig/lxdialog/checklist.c:325: 
> > fatal error: opening dependency file 
> > scripts/kconfig/lxdialog/.checklist.o.d: No such file or directory
> > compilation terminated.
> > make[2]: *** [scripts/kconfig/lxdialog/checklist.o] Error 1
> > make[1]: *** [oldconfig] Error 2
> > make: *** [oldconfig] Error 2
> > $ 
> >
> If the lxdialog directory is missing then kbuild barfs out.
> Fixed by followign patch that is already pushed out to my kbuild.git
> tree. Thanks for the reports (all senders added to to:).

I got the same thing on 2.6.18-rc3-mm2.

Andrew, if another -mm isn't imminent, could this patch make into into
the hot-fixes directory for -mm1 and/or -mm2?

BTW, I'm also seeing these in my build now:

	scripts/Makefile.host:88: host-objdirs=

It doesn't appear to hurt anything, but it is a bit weird looking.

-- Dave

