Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290216AbSAWXwY>; Wed, 23 Jan 2002 18:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290220AbSAWXwP>; Wed, 23 Jan 2002 18:52:15 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:28054 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S290216AbSAWXwB>; Wed, 23 Jan 2002 18:52:01 -0500
Date: Wed, 23 Jan 2002 23:53:35 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Rik van Riel <riel@conectiva.com.br>, Andrew Morton <akpm@zip.com.au>,
        Hans Reiser <reiser@namesys.com>,
        Andreas Dilger <adilger@turbolabs.com>, Chris Mason <mason@suse.com>,
        Shawn Starr <spstarr@sh0n.net>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: Possible Idea with filesystem buffering.
In-Reply-To: <20020123203500.L1930@redhat.com>
Message-ID: <Pine.LNX.4.21.0201232350280.2148-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2002, Stephen C. Tweedie wrote:
> 
> This is actually really important --- writepage on its own cannot
> distinguish between requests to flush something to disk (eg. msync or
> fsync), and requests to evict dirty data from memory.

Actually, that much can now be distinguished:
 PageLaunder(page) when evicting from memory,
!PageLaunder(page) when msync or fsync.

Hugh

