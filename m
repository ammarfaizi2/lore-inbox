Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277238AbRJDVZo>; Thu, 4 Oct 2001 17:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277234AbRJDVZe>; Thu, 4 Oct 2001 17:25:34 -0400
Received: from pizda.ninka.net ([216.101.162.242]:63648 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S277240AbRJDVZ1>;
	Thu, 4 Oct 2001 17:25:27 -0400
Date: Thu, 04 Oct 2001 14:25:23 -0700 (PDT)
Message-Id: <20011004.142523.54186018.davem@redhat.com>
To: arjan@fenrus.demon.nl
Cc: kravetz@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Context switch times
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E15pFor-0004sC-00@fenrus.demon.nl>
In-Reply-To: <20011004140417.C1245@w-mikek2.des.beaverton.ibm.com>
	<E15pFor-0004sC-00@fenrus.demon.nl>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: arjan@fenrus.demon.nl
   Date: Thu, 04 Oct 2001 22:14:13 +0100
   
   > Comments?
   
   2.4.x supports SSE on pentium III/athlons, so the SSE registers need to be
   saved/restored on a taskswitch as well.... that's not exactly free.

lat_ctx doesn't execute any FPU ops.  So at worst this happens once
on GLIBC program startup, but then never again.

This assumes I understand how lazy i387 restores work in the kernel
:-)

Franks a lot,
David S. Miller
davem@redhat.com
