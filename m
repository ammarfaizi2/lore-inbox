Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265137AbTLWNg2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 08:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265140AbTLWNg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 08:36:28 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:18323 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S265137AbTLWNg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 08:36:27 -0500
Subject: Re: [PATCH 2/2][RFC] Add dm-crypt target
From: Christophe Saout <christophe@saout.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Fruhwirth Clemens <clemens@endorphin.org>,
       Joe Thornber <thornber@sistina.com>
In-Reply-To: <20031223131355.A6864@infradead.org>
References: <1072129379.5570.73.camel@leto.cs.pocnet.net>
	 <20031222215236.GB13103@leto.cs.pocnet.net>
	 <20031223131355.A6864@infradead.org>
Content-Type: text/plain
Message-Id: <1072186582.4111.46.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 23 Dec 2003 14:36:22 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Di, den 23.12.2003 schrieb Christoph Hellwig um 14:13:

> Please include driver-private headers after kernel headers.
>
> > +struct crypt_c {
> 
> crypt_context?  The current name isn't very descriptive..
> 
> > +static kmem_cache_t *_io_cache;
> 
> Again a rather strange variable name.  What about dm_crypt_pool?
>
> Please kill these superflous wrappers.
> 
> > +static spinlock_t _kcryptd_lock = SPIN_LOCK_UNLOCKED;
> > +static struct bio *_bio_head;
> > +static struct bio *_bio_tail;
> > +
> > +static struct dm_daemon _kcryptd;
> 
> Again, rather strange naming..

This was done to be consistent with the other device-mapper code. I can
change it though.

Joe?

--
Christophe Saout <christophe@saout.de>
Please avoid sending me Word or PowerPoint attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html

