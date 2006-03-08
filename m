Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbWCHVX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWCHVX6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 16:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbWCHVX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 16:23:57 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:32465 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932278AbWCHVX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 16:23:56 -0500
Date: Wed, 8 Mar 2006 21:23:52 +0000
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] NFS: Unify NFS superblocks per-protocol per-server [try #7]
Message-ID: <20060308212352.GA7868@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, torvalds@osdl.org,
	akpm@osdl.org, steved@redhat.com, trond.myklebust@fys.uio.no,
	aviro@redhat.com, linux-fsdevel@vger.kernel.org,
	linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
	linux-kernel@vger.kernel.org
References: <20060308203018.25493.23720.stgit@warthog.cambridge.redhat.com> <20060308203028.25493.84121.stgit@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060308203028.25493.84121.stgit@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Everything in nfs4_get_root past the "create a mount to represent the NFS.."
comment in nfs4_get_root is generic and not nfs-specific.  this should move
into a helper in namei.c instead of adding all these odd exports.

what it's doing looks a little fishy aswell, but I'll come back to that later.

