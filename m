Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750935AbWDTRkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbWDTRkk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 13:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbWDTRkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 13:40:40 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:19633 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1750876AbWDTRkj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 13:40:39 -0400
Message-ID: <4447C791.2070901@oracle.com>
Date: Thu, 20 Apr 2006 10:40:33 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com, sct@redhat.com,
       aviro@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] FS-Cache: Add notification of page becoming writable
 to VMA ops
References: <20060420165927.9968.33912.stgit@warthog.cambridge.redhat.com> <20060420165930.9968.60742.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060420165930.9968.60742.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> The attached patch adds a new VMA operation to notify a filesystem or other
> driver about the MMU generating a fault because userspace attempted to write
> to a page mapped through a read-only PTE.

This will almost certainly help OCFS2 get shared writable mmap() right,
too, though it probably won't be the whole story.

- z
