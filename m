Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263017AbUJ1Vhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263017AbUJ1Vhm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 17:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262940AbUJ1Vgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 17:36:31 -0400
Received: from ip3e83a512.speed.planet.nl ([62.131.165.18]:21563 "EHLO
	made0120.speed.planet.nl") by vger.kernel.org with ESMTP
	id S262868AbUJ1VfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 17:35:17 -0400
Message-ID: <4181660C.3080202@planet.nl>
Date: Thu, 28 Oct 2004 23:35:08 +0200
From: Stef van der Made <svdmade@planet.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a5) Gecko/20041011
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel-2.6.10-rc1-mm1 compile issue
References: <418155F7.3010105@planet.nl> <20041028134351.E14339@build.pdx.osdl.net>
In-Reply-To: <20041028134351.E14339@build.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Chris,

I've tried the patch but it failed to apply. By the looks of the code 
the patch was already applied. It looks like a new issue :-(

Line 759 and on look like this

#if defined(PG_skipped)
        ClearPageSkipped(page);
#endif
        if (page->mapping != NULL)
                delete_from_page_cache(page);
        unlock_page(page);
}

Cheers,

Stef

Chris Wright wrote:

>* Stef van der Made (svdmade@planet.nl) wrote:
>  
>
>>fs/built-in.o(.text+0x7ac23): In function `drop_page':
>>: undefined reference to `delete_from_page_cache'
>>make: *** [.tmp_vmlinux1] Error 1
>>    
>>
>
>Fix was posted, try this archive link:
>
>http://marc.theaimsgroup.com/?l=linux-kernel&m=109887945018256&w=2
>
>thanks,
>-chris
>  
>

