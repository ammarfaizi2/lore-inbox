Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316544AbSGQS03>; Wed, 17 Jul 2002 14:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316512AbSGQSZZ>; Wed, 17 Jul 2002 14:25:25 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:5884 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S316544AbSGQSY0>; Wed, 17 Jul 2002 14:24:26 -0400
Date: Wed, 17 Jul 2002 14:27:25 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Anton Altaparmakov <aia21@cantab.net>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 13/13] lseek speedup
Message-ID: <20020717142725.B2645@redhat.com>
References: <3D3598F0.FBBA9DB6@zip.com.au> <5.1.0.14.2.20020717171311.00b00380@pop.cus.cam.ac.uk> <3D35A024.1635E12E@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D35A024.1635E12E@zip.com.au>; from akpm@zip.com.au on Wed, Jul 17, 2002 at 09:49:40AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2002 at 09:49:40AM -0700, Andrew Morton wrote:
> But protection of struct file should not be via any per-inode thing.

Why not make use of set_64bit instead of using a spinlock?  It might 
need a companion get_64bit, but at least on 64 bit machines they could  
be defined to use a direct load/store.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
