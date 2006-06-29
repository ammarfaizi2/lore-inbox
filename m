Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbWF2Bpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbWF2Bpf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 21:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWF2Bpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 21:45:35 -0400
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:24757 "EHLO
	mail7.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751272AbWF2Bpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 21:45:34 -0400
Date: Wed, 28 Jun 2006 21:45:32 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Andrew Morton <akpm@osdl.org>
cc: chrisw@sous-sol.org, linux-kernel@vger.kernel.org, sds@tycho.nsa.gov,
       dpquigl@tycho.nsa.gov
Subject: Re: [PATCH 1/3] SELinux: Extend task_kill hook to handle signals
 sent by AIO completion
In-Reply-To: <20060628175551.33737310.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0606282145090.18027@d.namei>
References: <Pine.LNX.4.64.0606281943240.17149@d.namei>
 <20060629001628.GQ11588@sequoia.sous-sol.org> <Pine.LNX.4.64.0606282034110.17541@d.namei>
 <20060628175551.33737310.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2006, Andrew Morton wrote:

> James Morris <jmorris@namei.org> wrote:
> >
> > On Wed, 28 Jun 2006, Chris Wright wrote:
> > 
> > > > diff -uprN -X /home/dpquigl/dontdiff linux-2.6.17-mm3/security/selinux/hooks.c linux-2.6.17-mm3-kill/security/selinux/hooks.c
> > > > --- linux-2.6.17-mm3/security/selinux/hooks.c	2006-06-28 13:58:59.000000000 -0400
> > > > +++ linux-2.6.17-mm3-kill/security/selinux/hooks.c	2006-06-28 14:40:00.000000000 -0400
> > > > @@ -45,6 +45,7 @@
> > > >  #include <linux/kd.h>
> > > >  #include <linux/netfilter_ipv4.h>
> > > >  #include <linux/netfilter_ipv6.h>
> > > > +#include <linux/selinux.h>
> > > 
> > > It's already included.
> > 
> > Not in the current Linus git tree.
> > 
> > $ cat .git/refs/heads/master
> > 27d68a36c4f1ca2fc6be82620843493462c08c51
> > 
> > $ grep selinux\\.h security/selinux/hooks.c
> > 
> 
> Catherine's AF_UNIX patch adds the same include.
> 
> What's the relative importance/safety on all of these patches, btw?  Does
> Catherine go first?

I'd say Catherine's should go first.


-- 
James Morris
<jmorris@namei.org>
