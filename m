Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932638AbVISVkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932638AbVISVkp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 17:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932658AbVISVkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 17:40:45 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:54944 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S932638AbVISVko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 17:40:44 -0400
Message-ID: <432F3054.70401@v.loewis.de>
Date: Mon, 19 Sep 2005 23:40:36 +0200
From: =?UTF-8?B?Ik1hcnRpbiB2LiBMw7Z3aXMi?= <martin@v.loewis.de>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernd Petrovitsch <bernd@firmix.at>
CC: =?UTF-8?B?Ik1hcnRpbiB2LiBMw7Z3aXMi?= <martin@v.loewis.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] Support UTF-8 scripts
References: <4Nvab-7o5-11@gated-at.bofh.it> <4Nvab-7o5-13@gated-at.bofh.it>	 <4Nvab-7o5-15@gated-at.bofh.it> <4Nvab-7o5-17@gated-at.bofh.it>	 <4Nvab-7o5-19@gated-at.bofh.it> <4Nvab-7o5-21@gated-at.bofh.it>	 <4Nvab-7o5-23@gated-at.bofh.it> <4Nvab-7o5-25@gated-at.bofh.it>	 <4Nvab-7o5-27@gated-at.bofh.it> <4NvjM-7CU-7@gated-at.bofh.it>	 <4NvjM-7CU-5@gated-at.bofh.it> <4NxbR-20S-1@gated-at.bofh.it>	 <4NEn7-3M5-7@gated-at.bofh.it> <4NTvO-yJ-13@gated-at.bofh.it>	 <4O1MJ-3Hf-5@gated-at.bofh.it> <4O8Oh-5jp-7@gated-at.bofh.it>	 <432E448D.2080402@v.loewis.de> <1127118382.1080.19.camel@tara.firmix.at>
In-Reply-To: <1127118382.1080.19.camel@tara.firmix.at>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Petrovitsch wrote:
>>>It depends on the definition of "character". There are other standards
>>>which define "character" as "byte".
>>
>>Certainly. However, you specifically talked about 'wc -c', and, in
>>wc(1), atleast in the implementation commonly used on Linux, characters
>>and bytes are not the same.
> 
> 
> Yes, now since multi-byte character sets gets more commonly used.
> However, I don't think you get this into the C standard. But we are now
> far off the discussion ....

It does indeed, so just one final clarification. wc(1) is not part
of the C standard - ISO 9899 does not talk about command line utilities
at all. The relevant standard is POSIX; IEEE Std 1003.1, 2004 Edition
says, in

http://www.opengroup.org/onlinepubs/009695399/utilities/wc.html

-c
    Write to the standard output the number of bytes in each input file.
[...]
-m
    Write to the standard output the number of characters in each input
file.

[...]
RATIONALE
[...]
The -c option stands for "character" count, even though it counts bytes.
This stems from the sometimes erroneous historical view that bytes and
characters are the same size. Due to international requirements, the -m
option (reminiscent of "multi-byte") was added to obtain actual
character counts.

Regards,
Martin
