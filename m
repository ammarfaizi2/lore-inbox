Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268357AbUHZKxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268357AbUHZKxT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 06:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268650AbUHZKxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 06:53:08 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:9226 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268580AbUHZKws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 06:52:48 -0400
Date: Thu, 26 Aug 2004 11:52:29 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Christian Mayrhuber <christian.mayrhuber@gmx.net>
Cc: reiserfs-list@namesys.com, Anton Altaparmakov <aia21@cam.ac.uk>,
       linux-fsdevel@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826115229.A18013@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Christian Mayrhuber <christian.mayrhuber@gmx.net>,
	reiserfs-list@namesys.com, Anton Altaparmakov <aia21@cam.ac.uk>,
	linux-fsdevel@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
References: <20040824202521.GA26705@lst.de> <20040825163225.4441cfdd.akpm@osdl.org> <1093510983.23289.6.camel@imp.csi.cam.ac.uk> <200408261245.47734.christian.mayrhuber@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200408261245.47734.christian.mayrhuber@gmx.net>; from christian.mayrhuber@gmx.net on Thu, Aug 26, 2004 at 12:45:47PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 12:45:47PM +0200, Christian Mayrhuber wrote:
> There is the reiser4() syscall which you surely don't want to implement for 
> other filesystems.

Actually a syscall that goes into filesystem code is the last thing we want.
But it's not in the submission, so let's keep that flame^H^H^H^Hdiscussion
for later.

> Once there is some experience with this new fancy stuff the dust what
> is useful/insecure, etc. and what is not will settle and can be condensed
> into a vfs api.
> Apps like samba and user scripts will have to be adapted once this is
> the case, but this should not be to big a problem if this stuff is marked 
> experimental.
> 
> People which want something stable can continue to use xattrs and a
> magnitude of filesystems for now.

Sure, no one stops you from playing around with new semantics.  But please
don't add them to the linux kernel stable series until we have semantics we
a) want to stick to for a while and b) actually work.

