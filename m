Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264512AbSIQUne>; Tue, 17 Sep 2002 16:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264513AbSIQUne>; Tue, 17 Sep 2002 16:43:34 -0400
Received: from pizda.ninka.net ([216.101.162.242]:899 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264512AbSIQUne>;
	Tue, 17 Sep 2002 16:43:34 -0400
Date: Tue, 17 Sep 2002 13:39:33 -0700 (PDT)
Message-Id: <20020917.133933.69057655.davem@redhat.com>
To: johnstul@us.ibm.com
Cc: anton.wilson@camotion.com, linux-kernel@vger.kernel.org
Subject: Re: do_gettimeofday vs. rdtsc in the scheduler
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1032294559.22815.180.camel@cog>
References: <200209172020.g8HKKPF13227@eng2.beaverton.ibm.com>
	<1032294559.22815.180.camel@cog>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: john stultz <johnstul@us.ibm.com>
   Date: 17 Sep 2002 13:29:18 -0700
   
   Some NUMA boxes do not have synced TSC, so on those systems your
   code won't work.

It would have been really nice if x86 had specified a "system tick"
register that incremented based upon the system bus cycles and thus
were immune the processor rates.

I foresee lots of patches coming which basically are "how does this
x86 system provide a stable synchronized tick source".
