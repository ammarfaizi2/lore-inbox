Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966365AbWKNVTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966365AbWKNVTv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 16:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966044AbWKNVTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 16:19:51 -0500
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:49389 "EHLO
	mail7.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S965997AbWKNVTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 16:19:50 -0500
Date: Tue, 14 Nov 2006 16:19:48 -0500 (EST)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: David Howells <dhowells@redhat.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, trond.myklebust@fys.uio.no,
       selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org, aviro@redhat.com,
       steved@redhat.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH 12/19] CacheFiles: Permit a process's create SID to be
 overridden
In-Reply-To: <20061114200647.12943.39802.stgit@warthog.cambridge.redhat.com>
Message-ID: <XMMS.LNX.4.64.0611141618300.25022@d.namei>
References: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com>
 <20061114200647.12943.39802.stgit@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2006, David Howells wrote:

> +static u32 selinux_set_fscreate_secid(u32 secid)
> +{
> +	struct task_security_struct *tsec = current->security;
> +	u32 oldsid = tsec->create_sid;
> +
> +	tsec->create_sid = secid;
> +	return oldsid;
> +}

The ability to set this needs to be mediated via MAC policy.

See selinux_setprocattr()



- James
-- 
James Morris
<jmorris@namei.org>
