Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262118AbVCJAGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbVCJAGL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 19:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbVCJAEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 19:04:06 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:48092 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262214AbVCJAAV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:00:21 -0500
Message-ID: <422F8EBE.5080803@austin.ibm.com>
Date: Wed, 09 Mar 2005 18:03:10 -0600
From: Steven Pratt <slpratt@austin.ibm.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ram <linuxram@us.ibm.com>
CC: Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/2] readahead: improve sequential read detection
References: <42260F30.BE15B4DA@tv-sign.ru> <1110412324.4816.89.camel@localhost>
In-Reply-To: <1110412324.4816.89.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram wrote:

>On Wed, 2005-03-02 at 11:08, Oleg Nesterov wrote:
>
>
>..snip...
>
>  
>
>>@@ -527,7 +527,7 @@ page_cache_readahead(struct address_spac
>> 	}
>> 
>> out:
>>-	return newsize;
>>+	return ra->prev_page + 1;
>>    
>>
>
>This change introduces one key behavioural change in
>page_cache_readahead(). Instead of returning the number-of-pages
>successfully read, it now returns the next-page-index which is yet to be
>read. Was this essential? 
>
>  
>
and unless filmap.c was changed accordingly this is broken..  need. to 
look at this more.

Steve

>At least, a comment towards this effect at the top of the function is
>worth adding.
>
>RP
>  
>

