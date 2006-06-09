Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030221AbWFIPml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030221AbWFIPml (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 11:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030183AbWFIPmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 11:42:40 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:7556 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S1030219AbWFIPmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 11:42:39 -0400
Date: Fri, 9 Jun 2006 09:42:38 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       cmm@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 0/13] extents and 48bit ext3
Message-ID: <20060609154238.GN1651@parisc-linux.org>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <20060609091327.GA3679@infradead.org> <20060609030759.48cd17a0.akpm@osdl.org> <44899653.1020007@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44899653.1020007@garzik.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 11:40:03AM -0400, Jeff Garzik wrote:
> Users are now forced to remember that, if they write to their filesystem 
> after using either $mmver or $korgver kernels, they are locked out of 
> using older kernels.
> 
> From the user's perspective, ext3 has no clear "metadata version 1", 
> "metadata version 2" division.  Thus they are now forced to keep a 
> matrix of kernel versions and ext3 feature flag support, to know which 
> kernels are usable with which data.  It is a support nightmare.

Hang on, you're going too far.  You have to enable extents with the
extent mount option.  Otherwise you don't get to use them.  The user
does, in fact, have a clear division, although maybe the blinky signs
aren't quite luminous enough.

I still think making ext3 bigger than 16TB is just silly.
