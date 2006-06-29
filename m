Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751849AbWF2Aha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849AbWF2Aha (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 20:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbWF2Aha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 20:37:30 -0400
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:31200 "EHLO
	mail1.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751849AbWF2Ah3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 20:37:29 -0400
Date: Wed, 28 Jun 2006 20:37:27 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Chris Wright <chrisw@sous-sol.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>,
       David Quigley <dpquigl@tycho.nsa.gov>
Subject: Re: [PATCH 1/3] SELinux: Extend task_kill hook to handle signals
 sent by AIO completion
In-Reply-To: <20060629001628.GQ11588@sequoia.sous-sol.org>
Message-ID: <Pine.LNX.4.64.0606282034110.17541@d.namei>
References: <Pine.LNX.4.64.0606281943240.17149@d.namei>
 <20060629001628.GQ11588@sequoia.sous-sol.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2006, Chris Wright wrote:

> > diff -uprN -X /home/dpquigl/dontdiff linux-2.6.17-mm3/security/selinux/hooks.c linux-2.6.17-mm3-kill/security/selinux/hooks.c
> > --- linux-2.6.17-mm3/security/selinux/hooks.c	2006-06-28 13:58:59.000000000 -0400
> > +++ linux-2.6.17-mm3-kill/security/selinux/hooks.c	2006-06-28 14:40:00.000000000 -0400
> > @@ -45,6 +45,7 @@
> >  #include <linux/kd.h>
> >  #include <linux/netfilter_ipv4.h>
> >  #include <linux/netfilter_ipv6.h>
> > +#include <linux/selinux.h>
> 
> It's already included.

Not in the current Linus git tree.

$ cat .git/refs/heads/master
27d68a36c4f1ca2fc6be82620843493462c08c51

$ grep selinux\\.h security/selinux/hooks.c



-- 
James Morris
<jmorris@namei.org>
