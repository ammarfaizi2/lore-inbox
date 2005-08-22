Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbVHVXLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbVHVXLQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 19:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbVHVXLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 19:11:16 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:29956 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932341AbVHVXLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 19:11:13 -0400
Date: Tue, 23 Aug 2005 01:11:11 +0200
From: Adrian Bunk <bunk@stusta.de>
To: serue@us.ibm.com
Cc: lkml <linux-kernel@vger.kernel.org>, linux-security-module@wirex.com,
       Andrew Morton <akpm@osdl.org>, Stephen Smalley <sds@tycho.nsa.gov>,
       James Morris <jmorris@redhat.com>, Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH -mm 3/3] [LSM] Stacking support for inode_init_security
Message-ID: <20050822231111.GM9927@stusta.de>
References: <20050822080401.GA26125@sergelap.austin.ibm.com> <20050822082028.GB25390@sergelap.austin.ibm.com> <20050822165209.GB5511@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050822165209.GB5511@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2005 at 11:52:09AM -0500, serue@us.ibm.com wrote:
> Quoting serue@us.ibm.com (serue@us.ibm.com):
> > This patch adds two stackable test LSMs which only define
> > inode_init_security().  Any file created while these modules are
> > loaded should have the xattrs ("security.name1", "value1") and
> > ("security.name2", "value2").
> > 
> > thanks,
> > -serge
> 
> I'd forgotten a 'quilt add'.  The following trivial patch against
> security/Makefile is necessary to actually compile the test LSMs...
> 
> thanks,
> -serge
> 
> Signed-off-by: Serge Hallyn <serue@us.ibm.com>
> 
> Index: linux-2.6.13-rc6-mm1/security/Makefile
> ===================================================================
> --- linux-2.6.13-rc6-mm1.orig/security/Makefile	2005-08-21 21:19:32.000000000 -0500
> +++ linux-2.6.13-rc6-mm1/security/Makefile	2005-08-22 15:19:41.000000000 -0500
> @@ -19,3 +19,4 @@ obj-$(CONFIG_SECURITY_CAPABILITIES)	+= c
>  obj-$(CONFIG_SECURITY_CAP_STACK)	+= commoncap.o cap_stack.o
>  obj-$(CONFIG_SECURITY_ROOTPLUG)		+= commoncap.o root_plug.o
>  obj-$(CONFIG_SECURITY_SECLVL)		+= seclvl.o
> +obj-m					+= testinitsec1.o testinitsec2.o

You want to build these modules always and always modular?

No matter whether the security subsystem is built modular or static?

No matter whether the user has enabled or completely disabled the 
security subsystem?

...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

