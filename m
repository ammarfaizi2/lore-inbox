Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbVKNXDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbVKNXDm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 18:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbVKNXDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 18:03:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39370 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932168AbVKNXDl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 18:03:41 -0500
Date: Mon, 14 Nov 2005 15:03:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org,
       linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
       nfsv4@linux-nfs.org
Subject: Re: [PATCH 0/12] FS-Cache: Generic filesystem caching facility
Message-Id: <20051114150347.1188499e.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511141428390.3263@g5.osdl.org>
References: <dhowells1132005277@warthog.cambridge.redhat.com>
	<Pine.LNX.4.64.0511141428390.3263@g5.osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> On Mon, 14 Nov 2005, David Howells wrote:
> >
> > This series of patches does four things:
> 
> Ok, interesting, and I like most of what I see..

Less impressed.  It (still) adds a very large amount of tricksy code which
pokes around in core pagecache functions, slows down the radix-tree
hotpath, exports mysterious symbols.  And that's on a 60-second scan. 

It'll be a sizeable job going through it in detail.  Not as sizeable as
writing it though ;)

All of this for an undisclosed speedup of AFS!

I think we need an NFS implementation and some numbers which make it
interesting.  Or at least, some AFS numbers, some explanation as to why
they can be extrapolated to NFS and some degree of interest from the NFS
guys.   Ditto CIFS.

Because it _is_ a lot of code.
