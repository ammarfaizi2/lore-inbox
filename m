Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264441AbUBOJue (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 04:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264446AbUBOJue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 04:50:34 -0500
Received: from gate.crashing.org ([63.228.1.57]:55197 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264441AbUBOJud (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 04:50:33 -0500
Subject: Re: oops w/ 2.6.2-mm1 on ppc32
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: mh@nadir.org, Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
In-Reply-To: <20040215001019.33e4089b.akpm@osdl.org>
References: <20040215074140.GA3840@nadir.org>
	 <1076831383.6958.38.camel@gaston>  <20040215001019.33e4089b.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1076838561.6949.42.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 15 Feb 2004 20:49:21 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Note that isofs_fill_super() calls sb_bread() before setting the blocksize.
> For this it is relying on blockdev.bd_block_size being set up
> appropriately.
> 
> Which all tends to imply that the underlying queue's ->hardsect_size is
> very wrong.
> 
> The code which is responsible for setting up the queue's hardsect_size
> appears to live in cdrom_read_toc()
> 
  .../...

I have to double check, but that sounds a bit like some oops report
I got with HFS/HFS+ on CD-ROMs... I'll check my archives tomorrow

Ben.


