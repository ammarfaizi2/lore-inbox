Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751068AbVHKPlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbVHKPlN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 11:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbVHKPlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 11:41:13 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:20230 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751068AbVHKPlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 11:41:12 -0400
Message-ID: <42FB7196.8000408@vmware.com>
Date: Thu, 11 Aug 2005 08:41:10 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: n l <walking.to.remember@gmail.com>
Cc: Giuliano Pochini <pochini@denise.shiny.it>, linux-kernel@vger.kernel.org
Subject: Re: why the interrupt handler should be marked "static" for it is
 never called directly from another file.
References: <6b5347dc05081101334c1a6e3c@mail.gmail.com>	 <Pine.LNX.4.58.0508111049010.5385@denise.shiny.it> <6b5347dc0508110203345af854@mail.gmail.com>
In-Reply-To: <6b5347dc0508110203345af854@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Aug 2005 15:40:56.0391 (UTC) FILETIME=[10789D70:01C59E8B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

n l wrote:

>I see, if a function in a module is not marked by static ,it can be
>accessed by any other function in kernel, while , using a static can
>avoid it .
>
>thanks a lot !!
>
>
>2005/8/11, Giuliano Pochini <pochini@denise.shiny.it>:
>  
>
>>On Thu, 11 Aug 2005, n l wrote:
>>
>>    
>>
>>>could you explain its reason for using static ?
>>>      
>>>
>>Anything which is never referenced from another file should be
>>static in order to keep namespace pollution low.
>>

There is actually another very good reason as well.  By marking 
functions static, you are telling the compiler that they may be only 
used in that file.  This allows the compiler to remove unused functions, 
which would be left in if implicitly declared "extern" by omitting the 
static.

Zach
