Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314267AbSDTAN3>; Fri, 19 Apr 2002 20:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314285AbSDTAN2>; Fri, 19 Apr 2002 20:13:28 -0400
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:43923 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S314267AbSDTAN0>; Fri, 19 Apr 2002 20:13:26 -0400
Message-ID: <3CC0B217.902@didntduck.org>
Date: Fri, 19 Apr 2002 20:11:03 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "H. Peter Anvin" <hpa@zytor.com>, andrea@suse.de, ak@suse.de,
        linux-kernel@vger.kernel.org, jh@suse.cz
Subject: Re: [PATCH] Re: SSE related security hole
In-Reply-To: <Pine.LNX.4.44.0204191708360.6542-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 19 Apr 2002, H. Peter Anvin wrote:
> 
>>Indeed.  Logically, FNINIT should have been extended to initialize it all -
>>- it is a security hole that it doesn't initialize MMX properly.
> 
> 
> Well, MMX should arguably be initialized with "emms", so the proper
> sequence migth be something like
> 
> 	if (sse)
> 		asm("emms");
> 	asm("fninit");
> 
> What does emms do to SSE2?
> 
> 		Linus
> 

All emms does is reset the tag word.  It doesn't touch the registers.

-- 

						Brian Gerst

