Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313187AbSDTWnb>; Sat, 20 Apr 2002 18:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313190AbSDTWna>; Sat, 20 Apr 2002 18:43:30 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22026 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313187AbSDTWna>; Sat, 20 Apr 2002 18:43:30 -0400
Message-ID: <3CC1EF05.6000702@zytor.com>
Date: Sat, 20 Apr 2002 15:43:17 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020312
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        Brian Gerst <bgerst@didntduck.org>, linux-kernel@vger.kernel.org,
        jh@suse.cz
Subject: Re: [PATCH] Re: SSE related security hole
In-Reply-To: <20020420201205.M1291@dualathlon.random> <Pine.LNX.4.33.0204201221120.11732-100000@penguin.transmeta.com> <20020420214114.A11894@wotan.suse.de> <20020420232818.N1291@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> As said in an earlier email it is a matter of memory bandwith, 59 bytes
> of icache and zero data, against 7 bytes of icache and 512bytes of data.
> the 512bytes of data are visibly slower, period. Saving mem bandwith is
> much more important than reducing the number of instructions, even more
> on SMP!
> 

It's not 512 bytes of data -- only the part that's actually used is 
accessed.

	-hpa

