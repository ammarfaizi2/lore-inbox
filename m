Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284757AbRLEWcI>; Wed, 5 Dec 2001 17:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284768AbRLEWbs>; Wed, 5 Dec 2001 17:31:48 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:43433 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S284757AbRLEWbn>; Wed, 5 Dec 2001 17:31:43 -0500
Message-ID: <3C0EA044.6000501@redhat.com>
Date: Wed, 05 Dec 2001 17:31:32 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011129
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nathan Bryant <nbryant@optonline.net>
CC: Mario Mikocevic <mozgy@hinet.hr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i810 audio patch
In-Reply-To: <3C0C16E7.70206@optonline.net> <3C0C508C.40407@redhat.com> <3C0C58DE.9020703@optonline.net> <3C0C5CB2.6000602@optonline.net> <3C0C61CC.1060703@redhat.com> <20011204153507.A842@danielle.hinet.hr> <3C0D1DD2.4040609@optonline.net> <3C0D223E.3020904@redhat.com> <3C0D350F.9010408@optonline.net> <3C0D3CF7.6030805@redhat.com> <3C0D4E62.4010904@optonline.net> <3C0D52F1.5020800@optonline.net> <3C0D5796.6080202@redhat.com> <3C0D5CB6.1080600@optonline.net> <3C0D5FC7.3040408@redhat.com> <3C0D77D9.70205@optonline.net> <3C0D8B00.2040603@optonline.net> <3C0D8F02.8010408@redhat.com> <3C0D9456.6090106@optonline.net> <3C0DA1CC.1070408@redhat.com> <3C0DAD26.1020906@optonline.net> <3C0DAF35.50008@redhat.com> <3C0E7DCB.6050600@optonline.net> <3C0E7DFB.2030400@optonline.net> <3C0E7F1C.4060603@redhat.com> <3C0E8DBF.5010000@optonline.net> <3C0E90B2.1030601@redhat.com> <3C0E935F.3070505@optonline.net> <3C0E97FD.9050909@optonline.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Bryant wrote:

> Nathan Bryant wrote:
> 
>>
>> also, I ran your other DEBUG_MMAP patch and the news is that count 
>> just sits at 65536 ad nauseum.
>>
> 
> this is because settrigger in 0.9 doesn't: it's setting LVI=CVI so it 
> goes nowhere.


Not true.  SETTRIGGER is (generally) only called once to start things 
(and things are getting started or else it would set at 0 instead of at 
65536).  After that, SETTRIGGER isn't typically called again unless you 
are turning the device off.  It's calls to GETOPTR that are suppossed to 
keep the LVI-CIV tail chasing going on.

> this was introduced by the second patch against 0.08 that 
> you sent me...
> 



-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

