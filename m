Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288233AbSAHSyp>; Tue, 8 Jan 2002 13:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288242AbSAHSyf>; Tue, 8 Jan 2002 13:54:35 -0500
Received: from [195.63.194.11] ([195.63.194.11]:56594 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S288233AbSAHSy0>; Tue, 8 Jan 2002 13:54:26 -0500
Message-ID: <3C3B3DBC.9070801@evision-ventures.com>
Date: Tue, 08 Jan 2002 19:43:08 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: "Cameron, Steve" <Steve.Cameron@compaq.com>
CC: linux-kernel@vger.kernel.org, "White, Charles" <Charles.White@compaq.com>
Subject: Re: PATCH 2.5.2-pre9 scsi cleanup
In-Reply-To: <45B36A38D959B44CB032DA427A6E10640167CF1C@cceexc18.americas.cpqcorp.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cameron, Steve wrote:

>Martin Dalecki [mailto:dalecki@evision-ventures.com] wrote,
>regarding removal of scsi_device_types[] from drivers/scsi/scsi.c
>
>>Cameron, Steve wrote:
>>
>[...]
>
>>>Hmmm, I was using that.... (In, for example, 
>>>the cciss patch here: http://www.geocities.com/smcameron 
>>>It's not any big deal, though.)
>>>
>>Precisely this "not any big deal" is the point: It was the wrong 
>>approach to a trivial problem ;-).
>>
>
>So what's the right approach?  I can invent my own easily enough, 
>but each driver doing its own thing doesn't seem right.  I assumed 
>that it was in scsi.c foi common usage, so each driver that wanted 
>to say, use these device type strings in diagnostic messages or 
>some such wouldn't have to reinvent this wheel, and so all the 
>drivers would consistently use the same names.  Will it be 
>replaced with something else?
>
>Just want to know so I don't waste (even more :-) time 
>doing something dumb.
>

Please just case in the ->type enum. And if you wan't to provide special 
messages, well
then please do it yourself, the removal showed, that nearly no one 
driver used the generic
stuff, so it wasn't trully generic at all. (It should be handled by some 
userlevel stuff anyway...)


