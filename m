Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136356AbRASCnQ>; Thu, 18 Jan 2001 21:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136828AbRASCnG>; Thu, 18 Jan 2001 21:43:06 -0500
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:64004 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S136813AbRASCmx>; Thu, 18 Jan 2001 21:42:53 -0500
From: bsuparna@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: Christoph Hellwig <hch@ns.caldera.de>
cc: linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
Message-ID: <CA2569D9.000ECCBC.00@d73mta03.au.ibm.com>
Date: Fri, 19 Jan 2001 08:05:41 +0530
Subject: Re: [Kiobuf-io-devel] Re: [PLEASE-TESTME] Zerocopy networking
	 patch, 2.4.0-1
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Ok. Then we need an additional more or less generic object that is used
for
>passing in a rw_kiovec file operation (and we really want that for many
kinds
>of IO). I thould mostly be used for communicating to the high-level
driver.
>
>/*
> * the name is just plain stupid, but that shouldn't matter
> */
>struct vfs_kiovec {
>    struct kiovec *     iov;
>
>    /* private data, mostly for the callback */
>    void * private;
>
>    /* completion callback */
>    void (*end_io) (struct vfs_kiovec *);
>    wait_queue_head_t wait_queue;
>};
>
>    Christoph

Shouldn't we have an error / status field too ?


  Suparna Bhattacharya
  Systems Software Group, IBM Global Services, India
  E-mail : bsuparna@in.ibm.com
  Phone : 91-80-5267117, Extn : 2525


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
