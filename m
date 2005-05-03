Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVECQXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVECQXO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 12:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVECQXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 12:23:14 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:49037 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261189AbVECQXC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 12:23:02 -0400
Message-ID: <4277A3F0.1010807@tmr.com>
Date: Tue, 03 May 2005 12:16:48 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
CC: "Guo, Racing" <racing.guo@intel.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, "Yu, Luming" <luming.yu@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]porting lockless mce from x86_64 to i386
References: <88056F38E9E48644A0F562A38C64FB60049EED02@scsmsx403.amr.corp.intel.com>
In-Reply-To: <88056F38E9E48644A0F562A38C64FB60049EED02@scsmsx403.amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pallipadi, Venkatesh wrote:

> I think what Andi meant was that instead of copying code from x86-64 
> to i386 and making x86-64 link to this i386 copy, you can leave the 
> code in x86-64 and link it from i386 part of the tree. 
> 
> Doing it either way should be OK with this mce code. But I feel, 
> despite of the patch size, it is better to keep all the shared 
> code in i386 tree and link it from x86-64. Otherwise, it may become 
> kind of messy in future, with various links between i386 and x86-64.
> Andi/Andrew: What do you suggest here?

Have you considered having a tree just for the shared code and links 
where appropriate? If nothing else that would make it blindingly obvious 
  that the code was shared, and avoid having someone do something 
unsharable because s/he didn't know there was a pointer to the code 
elsewhere.

I know it's slightly more complex, but also slightly safer.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

