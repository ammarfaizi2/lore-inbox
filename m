Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277089AbRJHTYv>; Mon, 8 Oct 2001 15:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277094AbRJHTYl>; Mon, 8 Oct 2001 15:24:41 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:59082 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S277089AbRJHTYa>; Mon, 8 Oct 2001 15:24:30 -0400
Date: Mon, 08 Oct 2001 12:20:59 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Jesse Barnes <jbarnes@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: Whining about NUMA. :)  [Was whining about 2.5...]
Message-ID: <1816279834.1002543659@mbligh.des.sequent.com>
In-Reply-To: <Pine.LNX.4.21.0110081548020.4899-100000@freak.distro.conectiva>
X-Mailer: Mulberry/2.0.8 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> That's what I was planning on ... we'd need m x n classzones, where m
>> was the number of levels, and n the number of nodes. Each search would
>> obviously be through m classzones. I'll go poke at the current code some more.
> 
> You say "numbers of levels" as in each level being a given number of nodes
> on that "level" distance ? 

Yes. 

For example, if the only different access speeds you have were "on the local
node" vs "on another node", and access times to all *other* nodes were the
same, you'd have 2 levels.

If you have "on the local node" (10 ns) vs "on any node 1 hop away" (100ns), 
"on any node 2 hops away" (110ns), that'd be 3 levels. (latency numbers picked
out of my portable random number generator ;-) ).

If the latencies on a 4 level system turn out to be 10,100,101,102  then it's only
going to be worth defining 2 levels. If they turn out to be 10,100,1000, 10000,
then it'll (probably) be worth doing 4 .... 

M.

