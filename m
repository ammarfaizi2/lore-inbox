Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751667AbWEPHsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbWEPHsM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 03:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751668AbWEPHsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 03:48:12 -0400
Received: from mx04.stofanet.dk ([212.10.10.14]:28388 "EHLO mx04.stofanet.dk")
	by vger.kernel.org with ESMTP id S1751666AbWEPHsL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 03:48:11 -0400
Date: Tue, 16 May 2006 09:46:28 +0200
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: mason@suse.com
Subject: Re: [PATCH] fcache: a remapping boot cache
Message-ID: <20060516074628.GA16317@suse.de>
References: <20060515091806.GA4110@suse.de> <20060515101019.GA4068@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060515101019.GA4068@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15 2006, Jens Axboe wrote:
> On Mon, May 15 2006, Jens Axboe wrote:
> > o Trying it on my notebook brought the time from the kernel starts
> >   loading to kde has fully auto-logged in down from 50 seconds to 38
> >   seconds. The primed boot took 61 seconds. The notebook is about 4
> >   months old and the file system is very fresh, so better results should
> >   be seen on more fragmented installs.
> 
> Update - the above numbers were with an older version and with the cache
> partition located at the very end of the drive (hence being a lot slower
> than the root partition at the front). The fcache boot takes 33 seconds
> now, from the kernel starts loading to the kde login has finished.
> Probably 5 seconds of that time is device probe and network setup (dunno
> why the latter is still sleeping so much, I disabled dhcp for this test
> to avoid waits (for both fcache and normal boot, of course)).

Updated patch available in the fcache branch of the block repo. Various
cleanups and fixes (nothing critical), and gets rid of the BIO_FCACHE
hack.

git://brick.kernel.dk/data/git/linux-2.6-block.git fcache

-- 
Jens Axboe

