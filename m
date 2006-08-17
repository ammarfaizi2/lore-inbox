Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbWHQVxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbWHQVxr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 17:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWHQVxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 17:53:46 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:4451 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932376AbWHQVxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 17:53:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=DGY0pmGW9lEQYdM3GDJH7XVtLWO2hfiubvVADcwCDsDrdZTh5N8atbffoY0RCj/hld4Q5FVW5WMYMSImuZOqfUMCrbZ6igwM965Rvl0WRFLleWeOzIKr2wTyLhfB1pg9h1bylIF5PlV60UE89YT0uql+wT4+73x2JbohYmvtpsU=
Message-ID: <44E4E57A.8050800@gmail.com>
Date: Thu, 17 Aug 2006 15:54:02 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc4-mm1 Run-time of Locking API testsuite
References: <44E4CC60.3080109@gmail.com> <9a8748490608171440h56fad8cesff32466a8beaf6f5@mail.gmail.com>
In-Reply-To: <9a8748490608171440h56fad8cesff32466a8beaf6f5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> On 17/08/06, Jim Cromie <jim.cromie@gmail.com> wrote:
>>
>> Note the non-trivial execution time difference:
>>
>> soekris:~/pinlab# egrep -e 'Locking|Good' dmesg-2.6.18-rc4-*
>> dmesg-2.6.18-rc4-mm1-sk:[   16.044699] | Locking API testsuite:
>> dmesg-2.6.18-rc4-mm1-sk:[   96.083576] Good, all 218 testcases passed! |
>> dmesg-2.6.18-rc4-sk:[   18.563808] | Locking API testsuite:
>> dmesg-2.6.18-rc4-sk:[   19.693692] Good, all 218 testcases passed! |
>>
> Interresting. On my box it takes at most a few seconds (don't have
> printk times enabled, so I can't give exact numbers). My best estimate
> is 2-3 seconds to run the self tests.
>
> I wonder what's so different about our machines. Mine is a Athlon64 X2
> 4400+ w/ 2GB RAM.
>
> relevant config options look identical to yours... Strange..
>

Mines a toy in comparison :-( but has its uses )

# cat /proc/cpuinfo
processor       : 0
vendor_id       : Geode by NSC
cpu family      : 5
model           : 9
model name      : Unknown
stepping        : 1
cpu MHz         : 266.670
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu tsc msr cx8 cmov mmx cxmmx up
bogomips        : 535.83

these are my closest-fit cpu choices

# CONFIG_M586MMX is not set
CONFIG_MGEODEGX1=y
# CONFIG_MGEODE_LX is not set

