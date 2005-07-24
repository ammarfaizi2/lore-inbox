Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbVGXMwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVGXMwq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 08:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbVGXMwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 08:52:36 -0400
Received: from mail.tmr.com ([64.65.253.246]:39882 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S261204AbVGXMwd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 08:52:33 -0400
Message-ID: <42E39082.1090906@tmr.com>
Date: Sun, 24 Jul 2005 08:58:42 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: randy_dunlap <rdunlap@xenotime.net>, torvalds@osdl.org,
       rlrevell@joe-job.com, cw@f00f.org, akpm@osdl.org, len.brown@intel.com,
       dtor_core@ameritech.net, vojtech@suse.cz, david.lang@digitalinsight.com,
       kernel@kolivas.org, linux-kernel@vger.kernel.org, mbligh@mbligh.org,
       diegocg@gmail.com, azarah@nosferatu.za.org, christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
References: <42D3E852.5060704@mvista.com>	 <d120d50005071312322b5d4bff@mail.gmail.com>	 <1121286258.4435.98.camel@mindpipe>	 <20050713134857.354e697c.akpm@osdl.org>	 <20050713211650.GA12127@taniwha.stupidest.org>	 <9a874849050714170465c979c3@mail.gmail.com>	 <1121386505.4535.98.camel@mindpipe>	 <Pine.LNX.4.58.0507141718350.19183@g5.osdl.org>	 <42D731A4.40504@gmail.com>	 <20050723164802.70b51b8a.rdunlap@xenotime.net> <9a874849050723165276f73cdf@mail.gmail.com>
In-Reply-To: <9a874849050723165276f73cdf@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:

>On 7/24/05, randy_dunlap <rdunlap@xenotime.net> wrote:
>  
>
>>On Fri, 15 Jul 2005 05:46:44 +0200 Jesper Juhl wrote:
>>
>>    
>>
>>>+static int __init jiffies_increment_setup(char *str)
>>>+{
>>>+     printk(KERN_NOTICE "setting up jiffies_increment : ");
>>>+     if (str) {
>>>+             printk("kernel_hz = %s, ", str);
>>>+     } else {
>>>+             printk("kernel_hz is unset, ");
>>>+     }
>>>+     if (!strncmp("100", str, 3)) {
>>>      
>>>
>>BTW, if someone enters "kernel_hz=1000", this check (above) for "100"
>>matches (detects) 100, not 1000.
>>
>>    
>>
>ouch. You are right - thanks. I'll be sure to fix that.
>I haven't had time to look more at this little thing for the last few
>days, but I'll get back to it soon. Thank you for the feedback.
>
>  
>
I have to admit that I like paranoid programming, and would rather see 
this look for "kernel_hz=" then convert the digits after to an integer 
and validate that. It would catch invalid values far better, allow other 
values to be either implemented as best as is possible if desired, and 
NOT ignore invalid values if they didn't match these predefined strings.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

