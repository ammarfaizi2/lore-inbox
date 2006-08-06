Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751514AbWHFEGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbWHFEGR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 00:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWHFEGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 00:06:17 -0400
Received: from [219.153.9.10] ([219.153.9.10]:48107 "EHLO iblink.com.cn")
	by vger.kernel.org with ESMTP id S1751514AbWHFEGQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 00:06:16 -0400
Message-ID: <44D56A97.2070603@idccenter.cn>
Date: Sun, 06 Aug 2006 12:05:43 +0800
From: "Tony.Ho" <linux@idccenter.cn>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: nathans@sgi.com
CC: jesper.juhl@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3-git3 - XFS - BUG: unable to handle kernel NULL pointer
 dereference at virtual address 00000078
References: <9a8748490608040122l69ff139dtaae27e8981022dae@mail.gmail.com> <20060804200549.A2414667@wobbly.melbourne.sgi.com> <44D55CE8.3090202@idccenter.cn>
In-Reply-To: <44D55CE8.3090202@idccenter.cn>
Content-Type: text/plain; charset=GB18030; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sorry about prev mail. I test on a wrong kernel.
The panic is not appear again, but random delete performance looks very bad.

Version  1.03       ------Sequential Output------ --Sequential Input- 
--Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- 
--Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  
/sec %CP
test           4G 50317  99 232444  54 109507  25 52287  98 329821  29  
1169   2
                    ------Sequential Create------ --------Random 
Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- 
-Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  
/sec %CP
                 16   104   1 +++++ +++    87   1   103   1 +++++ +++   
100   1
test,4G,50317,99,232444,54,109507,25,52287,98,329821,29,1169.4,2,16,104,1,+++++,+++,87,1,103,1,+++++,+++,100,1


Tony.Ho wrote:
> I'vs tested this patch, but the XFS panic is also reproducible, error 
> message is same as before.
>
>
> Nathan Scott wrote:
>> On Fri, Aug 04, 2006 at 10:22:21AM +0200, Jesper Juhl wrote:
>>  
>>> I just hit a BUG that looks XFS related.
>>>
>>> The machine is running 2.6.18-rc3-git3
>>>
>>> (more info below the BUG messages)
>>>
>>>     
>>
>> Thanks for reporting, Jesper - is it reproducible?  Could you try this
>> patch for me?  We had a couple of other reports of this, but the earlier
>> reporters have vanished ... could you let me know if this helps?
>>
>> cheers.
>>
>>   
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
