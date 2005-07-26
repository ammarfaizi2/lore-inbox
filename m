Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbVGZPt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbVGZPt0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 11:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261829AbVGZPsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 11:48:10 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:60166 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261682AbVGZPpy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 11:45:54 -0400
Message-ID: <42E65BAB.7030806@tmr.com>
Date: Tue, 26 Jul 2005 11:50:03 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Brown, Len" <len.brown@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Variable ticks
References: <F7DC2337C7631D4386A2DF6E8FB22B300424AC59@hdsmsx401.amr.corp.intel.com>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B300424AC59@hdsmsx401.amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brown, Len wrote:
>  
> 
>>>>Question one, are there other actions to consider?
>>>
>>>
>>>Yes.
>>>Speaking for ACPI C3 state, note that DMA also
>>>wakes up the CPU -- even if there was no device interrupt.
>>>(aka, "the trouble with USB")
>>
>>Trouble? Why would USB do DMA unless there was a device activity?
> 
> 
> look here:
> http://www.google.com/search?hl=en&q=usb+selective+suspend
> 
> Linux is working on it too, but it is in development.

Somehow I didn't ask that right... The stuff on selective disable is 
interesting, but my question is why a USB device, call it a keyboard, 
would do DMA unless I press a key, at which point response will be 
better if the CPU wakes up out of C3.

I understand that specialty attachments may send what amounts to keep 
alives, or gather data (webcam) you don't want, but the typical mouse 
and KB would seem to be things which generate DMA at user initiation, 
and would not be blocked for low power, only for suspend.
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
