Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263023AbTE0JXL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 05:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbTE0JXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 05:23:11 -0400
Received: from pointblue.com.pl ([62.89.73.6]:48395 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S263131AbTE0JWe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 05:22:34 -0400
Subject: Re: OUPS 2.5.69-bk19 coda-inode.c/slab.c
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030527004322.GA1690@delft.aura.cs.cmu.edu>
References: <1053971135.1968.6.camel@nalesnik.localhost>
	 <20030527004322.GA1690@delft.aura.cs.cmu.edu>
Content-Type: text/plain
Organization: K4 labs
Message-Id: <1054027420.1861.1.camel@nalesnik.localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 27 May 2003 10:23:43 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-27 at 01:43, Jan Harkes wrote:
> On Mon, May 26, 2003 at 06:45:40PM +0100, Grzegorz Jaskiewicz wrote:
> > following BUG() is started when coda is included into kernel. I have not
> > tried module, but i bet it will couse the same error.
> 
> Although I don't run the -bkXX releases, as far as I can see this is not
> related to anything in Coda bug, but probably a missing change to slab.c.
> 
> A flag was added to the slabcache to identify reclaimable slabs. I can
> see how this BUG would get triggered if your kernel was linked with an
> old version of slab.o or is missing the SLAB_RECLAIM_ACCOUNT related
> changes in slab.c.
> 
> Maybe "make clean ; make bzImage modules" will fix it?
I am allways doing that in case of problems. So this is not a case, I
bet this is missing patch for slab.c. Becouse this part i showed (along
with mine two debug lines) does not look to good.
 
-- 
Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 labs

