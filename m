Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbTD3PZP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 11:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262294AbTD3PZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 11:25:15 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:23052 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262290AbTD3PZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 11:25:08 -0400
Date: Wed, 30 Apr 2003 16:37:26 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@warthog.cambridge.redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       chas williams <chas@locutus.cmf.nrl.navy.mil>, torvalds@transmeta.com,
       viro@math.psu.edu, David Howells <dhowells@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add a stub by which a module can bind to the AFS syscall
Message-ID: <20030430163726.A9495@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@warthog.cambridge.redhat.com>,
	chas williams <chas@locutus.cmf.nrl.navy.mil>,
	torvalds@transmeta.com, viro@math.psu.edu,
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
References: <20030430160239.A8956@infradead.org> <27889.1051716620@warthog.warthog>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <27889.1051716620@warthog.warthog>; from dhowells@warthog.cambridge.redhat.com on Wed, Apr 30, 2003 at 04:30:20PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 30, 2003 at 04:30:20PM +0100, David Howells wrote:
> The four calls implemented by Linux are:
> 
>  (*) int setpag(void)
> 
>      Set Process Authentication Group number. This could easily be moved into
>      the kernel proper, with the PAG being stored in or depending from the
>      task structure somehow.

So please submit a patch for doing this in the kernel proper.

>  (*) int pioctl(const char *path, int cmd, void *arg, int followsymlink)
> 
>      Al Viro's favourite:-) Do ioctl() on a file refered to by pathname. Can't
>      be emulated by open/ioctl/close because:
> 
>      (a) it can operate directly on symbolic links.
> 
>      (b) some of its functions don't require a file and don't fail if one
> 	 can't be opened.

You don't expect we merge something that broken?  And then as multiplexer
inside a multiplexer?  This starts to look worse than sys_ipc()..

> 
>  (*) int afs_call(...)
> 
>      Local client control
> 
>  (*) int afs_icl(...)
> 
>      Local client status and logging control.

What's ...?

