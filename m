Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280266AbRKFTi7>; Tue, 6 Nov 2001 14:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279878AbRKFTiv>; Tue, 6 Nov 2001 14:38:51 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:59035 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S279568AbRKFTim>;
	Tue, 6 Nov 2001 14:38:42 -0500
Message-ID: <3BE83C39.4040807@candelatech.com>
Date: Tue, 06 Nov 2001 12:38:33 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Stephen Satchell <satch@concentric.net>
CC: Jakob =?ISO-8859-1?Q?=D8stergaard?= <jakob@unthought.net>,
        linux-kernel@vger.kernel.org,
        Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>,
        Tim Jansen <tim@tjansen.de>
Subject: Re: PROPOSAL: /proc standards (was dot-proc interface [was: /proc  stuff])
In-Reply-To: <20011105144112.Q11619@pasky.ji.cz> <E15zF9H-0000NL-00@wagner> <160MMf-1ptGtMC@fmrl05.sul.t-online.com> <20011104143631.B1162@pelks01.extern.uni-tuebingen.de> <160Nyq-2ACgt6C@fmrl07.sul.t-online.com> <20011104163354.C14001@unthought.net> <20011105144112.Q11619@pasky.ji.cz> <4.3.2.7.2.20011106093248.00bea990@10.1.1.42>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Stephen Satchell wrote:


> The /proc API was developed to solve a specific problem.  Now, people 
> have proposed and The Powers That Be have accepted extensions to the 
> /proc interface as a superior way to tune the kernel, particularly from 
> shell scripts, and to monitor the kernel, again from shell scripts.  
> It's a good thing, actually, in that it preserves the best of the Unix 
> mentality:  don't re-invent, reuse.


I definately like this approach....


> The RIGHT tool to fix the problem is the pen, not the coding pad.  I 
> hereby pick up that pen and put forth version 0.0.0.0.0.0.0.0.1 of the 
> Rules of /Proc:
> 
> 1)  IT SHOULD NOT BE PRETTY.  No tabs to line up columns.  No "progress 
> bars."  No labels except as "proc comments" (see later).  No in-line 
> labelling.


Tabs and/or multiple spaces should not be any harder to parse than
a single space, so I don't necessarily see the need to restrict them.



> 3)  All integral decimal values shall be assumed by both programs and 
> humans to consist of any number of bits.  [C'mon, people, dealing with 
> 64-bit or 128-bit numbers is NOT HARD.  If you don't know how, LEARN.  
> bc(1) can provide hints on how to do this -- use the Source, Luke.]  
> Numbers shall contain decimal digits [0-9] only.  Zero-padding is allowed.


Sometimes HEX is the best way to display things.  I think we should be
able to use 0xAABBCCDD type formatting.  The key here is to always prefix
with 0x so we can parse it correctly.




-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


