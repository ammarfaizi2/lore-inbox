Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277242AbRJDVwz>; Thu, 4 Oct 2001 17:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277243AbRJDVwp>; Thu, 4 Oct 2001 17:52:45 -0400
Received: from pizda.ninka.net ([216.101.162.242]:16801 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S277242AbRJDVwc>;
	Thu, 4 Oct 2001 17:52:32 -0400
Date: Thu, 04 Oct 2001 14:52:39 -0700 (PDT)
Message-Id: <20011004.145239.62666846.davem@redhat.com>
To: rgooch@ras.ucalgary.ca
Cc: arjan@fenrus.demon.nl, kravetz@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Context switch times
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200110042139.f94Ld5r09675@vindaloo.ras.ucalgary.ca>
In-Reply-To: <E15pFor-0004sC-00@fenrus.demon.nl>
	<20011004.142523.54186018.davem@redhat.com>
	<200110042139.f94Ld5r09675@vindaloo.ras.ucalgary.ca>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Richard Gooch <rgooch@ras.ucalgary.ca>
   Date: Thu, 4 Oct 2001 15:39:05 -0600

   David S. Miller writes:
   > lat_ctx doesn't execute any FPU ops.  So at worst this happens once
   > on GLIBC program startup, but then never again.
   
   Has something changed? Last I looked, the whole lmbench timing harness
   was based on using the FPU.

Oops, that's entirely possible...

But things are usually layed out like this:

	capture_start_time();
	context_switch_N_times();
	capture_end_time();

So the FPU hit is only before/after the runs, not during each and
every iteration.

Franks a lot,
David S. Miller
davem@redhat.com
