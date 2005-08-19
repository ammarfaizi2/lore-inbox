Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965183AbVHSVfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965183AbVHSVfk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 17:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965180AbVHSVfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 17:35:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1155 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965182AbVHSVfh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 17:35:37 -0400
Date: Fri, 19 Aug 2005 14:35:07 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Christoph Hellwig <hch@infradead.org>, vandrove@vc.cvut.cz,
       Andrew Morton <akpm@osdl.org>, linware@sh.cvut.cz,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Kernel bug: Bad page state: related to generic symlink code and
 mmap
In-Reply-To: <Pine.LNX.4.60.0508192214240.7312@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.58.0508191434470.3412@g5.osdl.org>
References: <1124450088.2294.31.camel@imp.csi.cam.ac.uk>
 <20050819142025.GA29811@parcelfarce.linux.theplanet.co.uk>
 <1124466246.2294.65.camel@imp.csi.cam.ac.uk> <Pine.LNX.4.58.0508190855350.3412@g5.osdl.org>
 <Pine.LNX.4.58.0508190913570.3412@g5.osdl.org> <Pine.LNX.4.58.0508190934470.3412@g5.osdl.org>
 <20050819165332.GD29811@parcelfarce.linux.theplanet.co.uk>
 <20050819180218.GE29811@parcelfarce.linux.theplanet.co.uk>
 <20050819180037.GA5686@infradead.org> <20050819193834.GF29811@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0508191323250.3412@g5.osdl.org>
 <Pine.LNX.4.60.0508192214240.7312@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Aug 2005, Anton Altaparmakov wrote:
> 
> You are throwing away the error return from vfs_readlink().  I suspect you 
> wanted:
> 
> +		cookie = ERR_PTR(res);

Yes, thanks.

		Linus
