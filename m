Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262972AbUDECK3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 22:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263012AbUDECK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 22:10:29 -0400
Received: from mail.tmr.com ([216.238.38.203]:56844 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S262972AbUDECK1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 22:10:27 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.4 : 100% CPU use on EIDE disk operarion, VIA chipset
Date: Sun, 04 Apr 2004 22:12:44 -0400
Organization: TMR Associates, Inc
Message-ID: <c4qf2i$1qj$1@gatekeeper.tmr.com>
References: <fa.g80v5s8.b2ofhi@ifi.uio.no> <fa.idlmgtf.1pluljl@ifi.uio.no> <406FC226.5090802@A8bb8.a.pppool.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1081130898 1875 192.168.12.10 (5 Apr 2004 02:08:18 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <406FC226.5090802@A8bb8.a.pppool.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Hartmann wrote:
> Bill Davidsen wrote:
> 
>> Andreas Hartmann wrote:
>>
>>> This is what top says during cp of 512MB-file:
>>> Cpu(s):  2.0% us,  8.3% sy,  0.0% ni,  0.0% id, 89.0% wa,  0.7% hi,  
>>> 0.0% si
>>>
>>> New is "wa", what probably means "wait". This value is very high as 
>>> long as the HD is writing or reading datas:
>>>
>>> cp dummy /dev/null
>>> produces this top-line:
>>> Cpu(s):  3.0% us,  5.3% sy,  0.0% ni,  0.0% id, 91.0% wa,  0.7% hi,  
>>> 0.0% si
>>
>>
>> Yes "wa" is not intuitive, some other operating systems use "wio" for 
>> "wait i/o" time. As noted in the other thread, you can try the 
>> deadline elevator or increased readahead for your load.
> 
> 
> If the processor and the kernel could do other things during wa, like
> compiling e.g., it would be no problem. But it seems to be, that this is
> not possible. Or did I oversee something?

Yes, wio is similar to idle, processor is available for work even if 
disk access is running slowly.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
