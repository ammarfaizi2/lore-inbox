Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311884AbSEHIWA>; Wed, 8 May 2002 04:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311898AbSEHIV7>; Wed, 8 May 2002 04:21:59 -0400
Received: from pizda.ninka.net ([216.101.162.242]:36262 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S311884AbSEHIV7>;
	Wed, 8 May 2002 04:21:59 -0400
Date: Wed, 08 May 2002 01:10:08 -0700 (PDT)
Message-Id: <20020508.011008.107273722.davem@redhat.com>
To: dipankar@in.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lockfree rtcache lookup using RCU
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020508125711.B10505@in.ibm.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Dipankar Sarma <dipankar@in.ibm.com>
   Date: Wed, 8 May 2002 12:57:11 +0530
   
   For 1 to 8 CPUs I used the test script
   to send a fixed number of packets to a single destination address.
   The results show that time needed for lookup continuously increases
   for 2.5.3 wherease for rt_rcu-2.5.3, it remains constant.

How does it perform for a write-heavy workload such
as a massive route flap?

Both are equally important.

Also, workload for single destination isn't all that interesting
since such a workload isn't all that common except in benchmarking.
