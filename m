Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263278AbSJHTU5>; Tue, 8 Oct 2002 15:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263265AbSJHTTx>; Tue, 8 Oct 2002 15:19:53 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:9994 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261476AbSJHTO6>; Tue, 8 Oct 2002 15:14:58 -0400
Date: Tue, 8 Oct 2002 20:20:38 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] [RFC] [PATCH 3/4] Add extended attributes to ext2/3
Message-ID: <20021008202038.A15692@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andreas Gruenbacher <agruen@suse.de>, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net
References: <E17yymK-00021n-00@think.thunk.org> <20021008195322.A14585@infradead.org> <200210082114.00576.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200210082114.00576.agruen@suse.de>; from agruen@suse.de on Tue, Oct 08, 2002 at 09:14:00PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2002 at 09:14:00PM +0200, Andreas Gruenbacher wrote:
> Users might just fill up all xattr space leaving no space for ACLs (or 
> similar). If user xattrs are disabled this can no longer occur, so some 
> administrators might be happy to have a choice.

Umm, that's why we have quota..

> With the registration API modules doing HSM/LSM/... can just register handlers 
> without having to modify the file system code. Otherwise we would have to 
> hand code additional hooks for independently loadable modules.

a) if the HSM/whatever is so standalone that it should patch ext2 code
   it is truely generic and thus above the filesystem.
b) you don;t even export the register/unregister to modules, not mention
   other ext2/ext3 core functionality that it would need.
c) looks at the 'would'  there is no such code currently and if it gets
   a real consern it still could be added.  Don't bloat the kernel
   more than you really need to..
