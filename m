Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264833AbTE1TGy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 15:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264835AbTE1TGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 15:06:53 -0400
Received: from [193.112.238.6] ([193.112.238.6]:22406 "EHLO caveman.xisl.com")
	by vger.kernel.org with ESMTP id S264833AbTE1TGw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 15:06:52 -0400
Message-ID: <3ED50BE3.8090105@xisl.com>
Date: Wed, 28 May 2003 20:20:03 +0100
From: John M Collins <jmc@xisl.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Question about memory-mapped files
References: <Pine.LNX.4.44.0305281818230.1427-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:

>On Wed, 28 May 2003, John M Collins wrote:
>  
>
>>If I invoke mmap to map a file to memory, and it succeeds, can I safely 
>>close the original file descriptor and rely on the memory still being 
>>mapped and the file still updated (possibly with mysnc)?
>>    
>>
>
>Yes, that's definitely a part of the specification of mmap,
>even if it's not mentioned on the man page.
>
>Note that the file on disk is likely not to be updated until
>some time after you unmap it, unless you use msync to force it.
>
Thanks - FYI the file mod time eventually got updated on HP-UX but not 
on Solaris (2.9) or Linux (2.4.21) - and it doesn't seem to update it 
even if you don't close the f.d. I think that has to be wrong if the 
manual page is anything to go by.

-- 
John Collins Xi Software Ltd www.xisl.com



