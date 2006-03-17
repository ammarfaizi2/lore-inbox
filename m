Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbWCQPxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbWCQPxm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 10:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbWCQPxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 10:53:42 -0500
Received: from pat.uio.no ([129.240.130.16]:58363 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750815AbWCQPxl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 10:53:41 -0500
Subject: Re: nfs udp 1000/100baseT issue
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: Bret Towe <magnade@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060317031834.43d3c1e6.akpm@osdl.org>
References: <dda83e780603151424u1b3ea605vd6e8dea896fc276e@mail.gmail.com>
	 <20060317031834.43d3c1e6.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 17 Mar 2006 10:53:25 -0500
Message-Id: <1142610805.4250.7.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.064, required 12,
	autolearn=disabled, AWL 1.75, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-17 at 03:18 -0800, Andrew Morton wrote:
> "Bret Towe" <magnade@gmail.com> wrote:
> >
> > ive seen this on kernels as far back as 2.6.13 on my own machines
> >  (was around that time when i accutally got gigabit at home)
> >  and recently noticed on some thin clients i maintain that 2.4 kernels
> >  on the client side are also affected so perhaps its server side issue?
> >  as all servers ive seen this on are 2.6 i havent used 2.4 kernels in ages
> >  on my own machines so i havent looked into if 2.4 has that issue server side
> >  or not
> 
> It would be interesting if you could do so.  I do recall that
> nfs-over-crappy-udp was much better behaved in 2.4...

The 2.6 servers allow clients to use 32k block sizes for READ and WRITE
requests, and set that as the preferred size for both TCP and UDP. In
2.4, they only supported 8k blocks.

Cheers,
  Trond

