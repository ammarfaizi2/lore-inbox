Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261860AbVAST0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbVAST0D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 14:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261859AbVAST0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 14:26:03 -0500
Received: from [207.168.29.180] ([207.168.29.180]:166 "EHLO jp.mwwireless.net")
	by vger.kernel.org with ESMTP id S261860AbVASTZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 14:25:55 -0500
Message-ID: <41EEB440.8010108@mvista.com>
Date: Wed, 19 Jan 2005 11:25:52 -0800
From: Steve Longerbeam <stevel@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: Hugh Dickins <hugh@veritas.com>, linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG in shared_policy_replace() ?
References: <Pine.LNX.4.44.0501191221400.4795-100000@localhost.localdomain> <41EE9991.6090606@mvista.com> <20050119174506.GH7445@wotan.suse.de> <41EEA575.9040007@mvista.com> <20050119183430.GK7445@wotan.suse.de> <41EEAE04.3050505@mvista.com> <20050119190927.GM7445@wotan.suse.de>
In-Reply-To: <20050119190927.GM7445@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andi Kleen wrote:

>On Wed, Jan 19, 2005 at 10:59:16AM -0800, Steve Longerbeam wrote:
>  
>
>>Andi Kleen wrote:
>>
>>    
>>
>>>>yeah, 2.6.10 makes sense to me too. But I'm working in -mm2, and
>>>>the new2 = NULL line is missing, hence my initial confusion. Trivial
>>>>patch to -mm2 attached. Just want to make sure it has been, or will be,
>>>>put back in.
>>>>  
>>>>
>>>>        
>>>>
>>>That sounds weird. Can you figure out which patch in mm removes it?
>>>
>>>
>>>      
>>>
>>found it:
>>
>>http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10/2.6.10-mm1/broken-out/mempolicy-optimization.patch
>>    
>>
>
>Are you sure? I don't see it touching the new2 free at the end of the function.
>  
>

it's not touching the new2 free, it's removing the new2 = NULL which is 
the problem.

-				new2 = NULL;



