Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263017AbTJOMcU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 08:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263018AbTJOMcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 08:32:20 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:260 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S263017AbTJOMcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 08:32:19 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: mika.penttila@kolumbus.fi, Linus Torvalds <torvalds@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, axboe@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [SCSI] Set max_phys_segments to sg_tablesize
Organization: Core
In-Reply-To: <20031015121449.CROQ7495.fep07-app.kolumbus.fi@mta.imail.kolumbus.fi>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.1-20030907 ("Sandray") (UNIX) (Linux/2.4.22-1-686-smp (i686))
Message-Id: <E1A9koj-0006Ca-00@gondolin.me.apana.org.au>
Date: Wed, 15 Oct 2003 22:31:53 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mika.penttila@kolumbus.fi wrote:
> 
>> Many SCSI host drivers assume that use_sg will be <= sg_tablesize.
>> Hence they may break under 2.6 as the number of physical segments
>> is not limited by sg_tablesize.  This patch fixes that.
> 
> Physical segments don't matter,  hw segments does and it's bounded by sg_tablesize.

It does matter if the driver can't cope with it.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
