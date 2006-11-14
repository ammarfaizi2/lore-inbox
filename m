Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966362AbWKNV1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966362AbWKNV1H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 16:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966366AbWKNV1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 16:27:07 -0500
Received: from mail5.sea5.speakeasy.net ([69.17.117.7]:34712 "EHLO
	mail5.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S966362AbWKNV1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 16:27:04 -0500
Date: Tue, 14 Nov 2006 16:27:01 -0500 (EST)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: David Howells <dhowells@redhat.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, trond.myklebust@fys.uio.no,
       selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org, aviro@redhat.com,
       steved@redhat.com
Subject: Re: [PATCH 16/19] CacheFiles: Deal with LSM when accessing the cache
In-Reply-To: <20061114200656.12943.98985.stgit@warthog.cambridge.redhat.com>
Message-ID: <XMMS.LNX.4.64.0611141625090.25022@d.namei>
References: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com>
 <20061114200656.12943.98985.stgit@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2006, David Howells wrote:

> @@ -80,6 +81,8 @@ struct cachefiles_cache {
>  	struct rb_root			active_nodes;	/* active nodes (can't be culled) */
>  	rwlock_t			active_lock;	/* lock for active_nodes */
>  	atomic_t			gravecounter;	/* graveyard uniquifier */
> +	u32				access_sid;	/* cache access SID */
> +	u32				cache_sid;	/* cache fs object SID */

Please uniformly name these security IDs 'secids' in the main kernel, to 
avoid confusion with session IDs.



- James
-- 
James Morris
<jmorris@namei.org>
