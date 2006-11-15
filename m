Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030651AbWKOQW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030651AbWKOQW7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 11:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030655AbWKOQW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 11:22:59 -0500
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:1220 "EHLO
	mail7.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1030651AbWKOQW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 11:22:58 -0500
Date: Wed, 15 Nov 2006 11:22:55 -0500 (EST)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: David Howells <dhowells@redhat.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, trond.myklebust@fys.uio.no,
       selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org, aviro@redhat.com,
       steved@redhat.com
Subject: Re: [PATCH 12/19] CacheFiles: Permit a process's create SID to be
 overridden 
In-Reply-To: <24555.1163598644@redhat.com>
Message-ID: <XMMS.LNX.4.64.0611151120240.8593@d.namei>
References: <XMMS.LNX.4.64.0611141618300.25022@d.namei> 
 <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com>
 <20061114200647.12943.39802.stgit@warthog.cambridge.redhat.com> 
 <24555.1163598644@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006, David Howells wrote:

> James Morris <jmorris@namei.org> wrote:
> 
> > The ability to set this needs to be mediated via MAC policy.
> 
> Something like this, you mean?

Yes, although perhaps writing to tsec->kern_create_sid or similar, which 
then overrides tsec->create_sid if set.  Also need 
/proc/pid/attr/kern_fscreate as a read only node.


> +	error = task_has_perm(current, current, PROCESS__SETFSCREATE);

I wonder if we also need 'relabelto' and 'relabelfrom' permissions, to 
control which labels are being used.



- James
-- 
James Morris
<jmorris@namei.org>
