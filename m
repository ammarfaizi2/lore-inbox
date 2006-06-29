Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbWF2AwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbWF2AwZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 20:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWF2AwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 20:52:25 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:28035 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751310AbWF2AwY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 20:52:24 -0400
Date: Wed, 28 Jun 2006 17:52:04 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: James Morris <jmorris@namei.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
       David Quigley <dpquigl@tycho.nsa.gov>
Subject: Re: [PATCH 1/3] SELinux: Extend task_kill hook to handle signals sent by AIO completion
Message-ID: <20060629005204.GR11588@sequoia.sous-sol.org>
References: <Pine.LNX.4.64.0606281943240.17149@d.namei> <20060629001628.GQ11588@sequoia.sous-sol.org> <Pine.LNX.4.64.0606282034110.17541@d.namei>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606282034110.17541@d.namei>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* James Morris (jmorris@namei.org) wrote:
> On Wed, 28 Jun 2006, Chris Wright wrote:
> 
> > > diff -uprN -X /home/dpquigl/dontdiff linux-2.6.17-mm3/security/selinux/hooks.c linux-2.6.17-mm3-kill/security/selinux/hooks.c
> > > --- linux-2.6.17-mm3/security/selinux/hooks.c	2006-06-28 13:58:59.000000000 -0400
> > > +++ linux-2.6.17-mm3-kill/security/selinux/hooks.c	2006-06-28 14:40:00.000000000 -0400
> > > @@ -45,6 +45,7 @@
> > >  #include <linux/kd.h>
> > >  #include <linux/netfilter_ipv4.h>
> > >  #include <linux/netfilter_ipv6.h>
> > > +#include <linux/selinux.h>
> > 
> > It's already included.
> 
> Not in the current Linus git tree.
> 
> $ cat .git/refs/heads/master
> 27d68a36c4f1ca2fc6be82620843493462c08c51
> 
> $ grep selinux\\.h security/selinux/hooks.c

Sorry, you're right, my tree is still patched with Catherine's AF_UNIX
getpeersec patch.

thanks,
-chris
