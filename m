Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263246AbTEINTQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 09:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263250AbTEINTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 09:19:15 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:1038 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263246AbTEINTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 09:19:13 -0400
Date: Fri, 9 May 2003 14:31:47 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, arjanv@redhat.com,
       viro@parcelfarce.linux.theplanet.co.uk, drepper@redhat.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] New authentication management syscalls
Message-ID: <20030509143147.A23197@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Trond Myklebust <trond.myklebust@fys.uio.no>, arjanv@redhat.com,
	viro@parcelfarce.linux.theplanet.co.uk, drepper@redhat.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <11183.1052485877@warthog.warthog>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <11183.1052485877@warthog.warthog>; from dhowells@redhat.com on Fri, May 09, 2003 at 02:11:17PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 09, 2003 at 02:11:17PM +0100, David Howells wrote:
>  (3) settok(const char *fs, const char *key, size_t size, const void *data)

fs is the path to a mount point?

>      Present data to the named filesystem as being the authentication token
>      for the specified key (eg: an AFS cell). If accepted, this token should
>      be stored in the PAG to which the calling process belongs.

s/filesystem/mount instance/

> 
> 	struct file_system_type {
> 	        ...
> 		int settok(struct file_system_type *fstype,
> 			   const char *domain,
> 			   size_t size,
> 			   const void *data);
> 	};

This should go into super_operations instead.

