Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317034AbSFFSMG>; Thu, 6 Jun 2002 14:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317068AbSFFSMF>; Thu, 6 Jun 2002 14:12:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40969 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317034AbSFFSME>;
	Thu, 6 Jun 2002 14:12:04 -0400
Message-ID: <3CFFA55F.8000008@mandrakesoft.com>
Date: Thu, 06 Jun 2002 14:09:35 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: lei_hu@ali.com.tw, alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] update for ALi Audio Driver (0.14.10)
In-Reply-To: <OF7057B5B9.A6CA3C3B-ON48256BD0.0020BE4E@ali.com.tw> <1023365907.22186.9.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Thu, 2002-06-06 at 07:27, lei_hu@ali.com.tw wrote:
>  
>
>>Dear all
>> I rewrite the part to read/write registers of the audio codec  for Ali 5451
>>Audio Driver.
>>    
>>
>
>The formatting seems to have gone a bit strange but I'll clean that up
>and merge the change
>  
>


Why?  Hardware semaphores are notorious for causing hangs.  Nobody is 
sharing the hardware under Linux, so I think we should enable access on 
init, and not disable access until driver close.  IMO the mixer should 
be guarded by a Linux kernel semaphore...  I have a patch from Thomas 
Sailer (I think) lying around somewhere that does just that to the via 
audio driver.  Maybe we can adapt it.
(I cc'd this little detail, in my ali/trident.c patch review, to you)

    Jeff




