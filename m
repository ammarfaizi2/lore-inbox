Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUE1RBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUE1RBG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 13:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbUE1RBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 13:01:05 -0400
Received: from [213.146.154.40] ([213.146.154.40]:39864 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261426AbUE1RAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 13:00:53 -0400
Date: Fri, 28 May 2004 18:00:51 +0100
From: Christoph Hellwig <hch@infradead.org>
To: braam <braam@clusterfs.com>
Cc: arjanv@redhat.com, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, "'Phil Schwan'" <phil@clusterfs.com>
Subject: Re: [PATCH/RFC] Lustre VFS patch
Message-ID: <20040528170051.GA30411@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	braam <braam@clusterfs.com>, arjanv@redhat.com, torvalds@osdl.org,
	akpm@osdl.org, linux-kernel@vger.kernel.org,
	'Phil Schwan' <phil@clusterfs.com>
References: <1085406284.2780.13.camel@laptop.fenrus.com> <20040528165649.91F1F3100D3@moraine.clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040528165649.91F1F3100D3@moraine.clusterfs.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2004 at 12:56:40AM +0800, braam wrote:
> Mostly checks are done like in sys_rename.  
> 
> Some cases require new distributed state in the FS, such as the fact that a
> certain directory is a mountpoint, possibly not on the node doing a rename,
> but on another node.  
> 
> For this the Linux VFS has no api - we added something we call "pinning" for
> this in 2.4, but not in 2.6 yet.

In general I'd be happier to see code like that residing in the VFS,
especially as I guess other filesystems like AFS would like to have similar
features.In general I'd be happier to see code like that residing in the VFS,
especially as I guess other filesystems like AFS would like to have similar
features.

Where's the current lustre code that sits behind those interfaces?  Do you
have a patch that adds the lustre client to the kernel instead of the huge
cvs repository containing all kinds of unrelated code ala the obsolete
lustre 1.0?

