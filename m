Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262955AbUJ1VHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262955AbUJ1VHv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 17:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263115AbUJ1VHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 17:07:48 -0400
Received: from [129.105.5.125] ([129.105.5.125]:25751 "EHLO
	delta.ece.northwestern.edu") by vger.kernel.org with ESMTP
	id S262955AbUJ1VDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 17:03:09 -0400
Message-ID: <41815EED.9070202@ece.northwestern.edu>
Date: Thu, 28 Oct 2004 16:04:45 -0500
From: Lei Yang <lya755@ece.northwestern.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040921
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "\"Shesha B. \" Sreenivasamurthy" <shesha@inostor.com>
Cc: LinuxKernel Group <linux-kernel@vger.kernel.org>,
       kernelnewbies <kernelnewbies@nl.linux.org>
Subject: Re: set blksize of block device
References: <417FE6A8.5090803@ece.northwestern.edu>	 <417FE937.1040304@ece.northwestern.edu>	 <41804F04.4000300@ece.northwestern.edu> <1098981325.3279.5.camel@arcane>
In-Reply-To: <1098981325.3279.5.camel@arcane>
X-Enigmail-Version: 0.76.8.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shesha B. Sreenivasamurthy wrote:

>Firstly you cannot set the block size to lesser than 512. 
>
>When there is a request for the IO, you populate "struct req" data
>structure which you will pass it to the kernel or lower level SCSI/SATA
>driver. In the "struct req" there is a field "b_size" which may be what
>you are interested in. At the user level you can use the IOCTLs to set
>the block size of the RAW block device.
>
>-Shesha
>  
>
I understand that for real block device (like hard disk), block size 
cannot be less than 512. But to ramdisks, I think they are truely random 
addressable, and should be able to move on blocks even with size of 2 bytes.

Any comments?

>On Wed, 2004-10-27 at 18:44, Lei Yang wrote:
>  
>
>>If nobody could answer this question, what about another one? Is there a 
>>system call or a kernel interface that would allow me to write a block 
>>of data to block 1 of a certain block device?
>>
>>Thanks for your reply in advance!
>>
>>Lei
>>
>>Lei Yang wrote:
>>
>>    
>>
>>>Please cc me if you have answers to this, I am not on the list. Thanks 
>>>a lot!
>>>
>>>Lei Yang wrote:
>>>
>>>      
>>>
>>>>Hello,
>>>>
>>>>I am learning block device drivers and have a newbie question. Given 
>>>>a block device, is there anyway that I could set its block size? For 
>>>>example, I want to write a block device driver that will work on an 
>>>>existing block device.  In this driver, I want block size smaller. 
>>>>(The idea looks confusing but I could explain if anybody is 
>>>>interested :- )  However,  typically the block size is 1KB, now I 
>>>>want to set it to 512 or 256.  Can I do it?
>>>>
>>>>TIA
>>>>Lei
>>>>
>>>>        
>>>>
>>>
>>>      
>>>
>>
>>--
>>Kernelnewbies: Help each other learn about the Linux kernel.
>>Archive:       http://mail.nl.linux.org/kernelnewbies/
>>FAQ:           http://kernelnewbies.org/faq/
>>    
>>


