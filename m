Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934217AbWKTW33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934217AbWKTW33 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 17:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934272AbWKTW33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 17:29:29 -0500
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:19353 "EHLO
	mail3.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S934217AbWKTW32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 17:29:28 -0500
Date: Mon, 20 Nov 2006 17:29:25 -0500 (EST)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, trond.myklebust@fys.uio.no,
       selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org, aviro@redhat.com,
       steved@redhat.com
Subject: Re: [PATCH 12/19] CacheFiles: Permit a process's create SID to be
 overridden
In-Reply-To: <1164048073.13758.29.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <XMMS.LNX.4.64.0611201727470.31270@d.namei>
References: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com>
  <20061114200647.12943.39802.stgit@warthog.cambridge.redhat.com> 
 <XMMS.LNX.4.64.0611141618300.25022@d.namei> <1164048073.13758.29.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2006, Stephen Smalley wrote:

> > The ability to set this needs to be mediated via MAC policy.
> > 
> > See selinux_setprocattr()
> 
> That's different - selinux_set_fscreate_secid() is for internal use by a
> kernel module that wishes to temporarily assume a particular fscreate
> SID, whereas selinux_setprocattr() handles userspace writes
> to /proc/self/attr nodes.  Imposing a permission check here makes no
> sense.

Well, the hook is exported generally to the kernel, so we need to 
ensure that it is documented with a big warning.  The name of the hook 
should perhaps make it more obvious,  like set_internal_ or so.



- James
-- 
James Morris
<jmorris@namei.org>
