Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312560AbSEHJWL>; Wed, 8 May 2002 05:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312576AbSEHJWK>; Wed, 8 May 2002 05:22:10 -0400
Received: from pizda.ninka.net ([216.101.162.242]:5031 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S312560AbSEHJWJ>;
	Wed, 8 May 2002 05:22:09 -0400
Date: Wed, 08 May 2002 02:09:32 -0700 (PDT)
Message-Id: <20020508.020932.128330582.davem@redhat.com>
To: dipankar@in.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lockfree rtcache lookup using RCU
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020508142433.D10505@in.ibm.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Dipankar Sarma <dipankar@in.ibm.com>
   Date: Wed, 8 May 2002 14:24:33 +0530

   On Wed, May 08, 2002 at 01:10:08AM -0700, David S. Miller wrote:
   > Also, workload for single destination isn't all that interesting
   > since such a workload isn't all that common except in benchmarking.
   
   A heavily loaded webserver with NATed ip addresses. Would this not
   result in many server processes looking up the same ip address ?

The more common situation is server N IP (where N is 1 or a very small
number), destination clients == thousands of IPs.

So looking up the same dst cache entry with each benchmark client
is very unrealistic.  Try a unique IP address for every single lookup.

