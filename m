Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262214AbSIZG7n>; Thu, 26 Sep 2002 02:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262213AbSIZG7n>; Thu, 26 Sep 2002 02:59:43 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:21190 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S262212AbSIZG7l>; Thu, 26 Sep 2002 02:59:41 -0400
Message-ID: <3D92B17C.9030504@myrealbox.com>
Date: Thu, 26 Sep 2002 09:04:28 +0200
From: "Pedro M. Rodrigues" <pmanuel@myrealbox.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Warning - running *really* short on DMA buffers while doing file
 transfers
References: <20020925232736.A19209@shookay.newview.com> <20020926061419.GA12862@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Wed, Sep 25 2002, Mathieu Chouquet-Stringer wrote:
> 
>>	  Hello!
>>
>>I've upgraded a while to 2.4.19 and my box has been happy for the last 52
>>days (it's a dual PIII). Tonight while going through my logs, I've found
>>these:
>>
>>Sep 25 22:18:41 bigip kernel: Warning - running *really* short on DMA buffers
>>Sep 25 22:18:47 bigip last message repeated 55 times
>>Sep 25 22:19:41 bigip last message repeated 71 times
> 
> 
> This is fixed in 2.4.20-pre
> 
> 

    I reported this same problem some weeks ago - 
http://marc.theaimsgroup.com/?l=linux-kernel&m=103069116227685&w=2 . 
2.4.20pre kernels solved the error messages flooding the console, and 
improved things a bit, but system load still got very high and disk read 
and write performance was lousy. Adding more memory and using a 
completely different machine didn't help. What did? Changing the Adaptec 
scsi driver to aic7xxx_old . The performance was up 50% for writes and 
90% for reads, and the system load was acceptable. And i didn't even had 
to change the RedHat kernel (2.4.18-10) for a custom one. The storage 
was two external Arena raid boxes, btw.


Regards,
Pedro


