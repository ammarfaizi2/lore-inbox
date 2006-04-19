Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWDSVYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWDSVYD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 17:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbWDSVYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 17:24:03 -0400
Received: from pat.uio.no ([129.240.10.6]:10741 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751095AbWDSVYB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 17:24:01 -0400
Subject: Re: Linux 2.6.17-rc2
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Diego Calleja <diegocg@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0604191111170.3701@g5.osdl.org>
References: <Pine.LNX.4.64.0604182013560.3701@g5.osdl.org>
	 <20060419200001.fe2385f4.diegocg@gmail.com>
	 <Pine.LNX.4.64.0604191111170.3701@g5.osdl.org>
Content-Type: text/plain
Date: Wed, 19 Apr 2006 17:23:47 -0400
Message-Id: <1145481827.8440.30.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.104, required 12,
	autolearn=disabled, AWL 1.71, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-19 at 11:44 -0700, Linus Torvalds wrote:
> 
> On Wed, 19 Apr 2006, Diego Calleja wrote:
> >
> > Could someone give a long high-level description of what splice() and tee()
> > are?
> 
> The _really_ high-level concept is that there is now a notion of a "random 
> kernel buffer" that is exposed to user space.
> 
> In other words, splice() and tee() work on a kernel buffer that the user 
> has control over, where "splice()" moves data to/from the buffer from/to 
> an arbitrary file descriptor, while "tee()" copes the data in one buffer 
> to another.

Any chance this could be adapted to work with all those DMA (and RDMA)
engines that litter our motherboards? I'm thinking in particular of
stuff like the drm drivers, and userspace rdma.

Cheers,
  Trond

