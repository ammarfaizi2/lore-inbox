Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314420AbSEFMrL>; Mon, 6 May 2002 08:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314422AbSEFMrK>; Mon, 6 May 2002 08:47:10 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:48382 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S314420AbSEFMrI>; Mon, 6 May 2002 08:47:08 -0400
Message-ID: <3CD67A98.40205@didntduck.org>
Date: Mon, 06 May 2002 08:44:08 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>,
        Linux-Kernel <linux-kernel@vger.kernel.org>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] percpu updates
In-Reply-To: <3CD06ACE.1090402@didntduck.org> <3CD4B042.A4355FD3@zip.com.au> <3CD55FF0.2030909@didntduck.org> <3CD64562.9AB4D3D7@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Brian Gerst wrote:
> 
>>Andrew Morton wrote:
>>
>>>Brian Gerst wrote:
>>>
>>>
>>>>These patches convert some of the existing arrays based on NR_CPUS to
>>>>use the new per cpu code.
>>>>
>>>
>>...
>>Andrew, could you try this patch?  I suspect something in setup_arch()
>>is touching the per cpu area before it gets copied for the other cpus.
>>This patch makes certain the boot cpu area is setup ASAP.
> 
> 
> This little recidivist is still using gcc-2.91.66.  It is not
> placing the percpu data in the correct section.  It is not 
> entirely obvious why.
> 
> I downgraded to 2.95.3 (build time went from 2:45 to 3:15, giving
> nothing in return) and Brian's patch worked OK.
> 
> ho hum.  So.  2.91.66, rest in peace.  I shall miss you.

Aha.  I was starting to wonder about the compiler.

-- 

						Brian Gerst

