Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbTKBJ1d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 04:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbTKBJ1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 04:27:33 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:33290 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S261595AbTKBJ1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 04:27:32 -0500
Date: Sun, 2 Nov 2003 20:27:23 +1100
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0test9 Reiserfs boot time "buffer layer error at fs/buffer.c:431"
Message-ID: <20031102092723.GA4964@gondor.apana.org.au>
References: <20031029141931.6c4ebdb5.akpm@osdl.org> <E1AGCUJ-00016g-00@gondolin.me.apana.org.au> <20031101233354.1f566c80.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031101233354.1f566c80.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 01, 2003 at 11:33:54PM -0800, Andrew Morton wrote:
> 
> aargh.  I thought Debian's 2.6 kernels were unmodified.  Are they carrying
> any other changes?

Yes we are.  You can find the changes in

http://http.us.debian.org/debian/pool/main/k/kernel-source-2.6.0-test9/

> That _should_ work.  The pagecache pages should be in such a state that all
> buffers are freeable and yes, we can leave the pagecache there.  But this
> could cause problems if the device was repartitioned in between, or if it
> was hotswapped.  I don't think we shoot down pagecache anywhere else for
> this.

Yes, however it should be safe to stop set_blocksize from calling
truncate_inode_pages, right?

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
