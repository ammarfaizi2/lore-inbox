Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283320AbRLDTYk>; Tue, 4 Dec 2001 14:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282910AbRLDTWy>; Tue, 4 Dec 2001 14:22:54 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:44348 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S283265AbRLDTVf>; Tue, 4 Dec 2001 14:21:35 -0500
Message-ID: <3C0D223E.3020904@redhat.com>
Date: Tue, 04 Dec 2001 14:21:34 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011129
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nathan Bryant <nbryant@optonline.net>
CC: Mario Mikocevic <mozgy@hinet.hr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i810 audio patch
In-Reply-To: <3C0C16E7.70206@optonline.net> <3C0C508C.40407@redhat.com> <3C0C58DE.9020703@optonline.net> <3C0C5CB2.6000602@optonline.net> <3C0C61CC.1060703@redhat.com> <20011204153507.A842@danielle.hinet.hr> <3C0D1DD2.4040609@optonline.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Bryant wrote:

> Mario Mikocevic wrote:
> 
>> modprobe produced an oops (17-pre2), module is left in init state :
>>
> Yep. In the i810_configure_clocking() function, immediately before the 
> call to i810_set_dac_rate(), add a line "clocking = 48000;"
> 

There is a new version of the driver (0.07) on my web site.  It has this 
issue and one other issue fixed (hopefully).  The other issue is when 
using artsd with the 0.06 driver, I had a report that artsd would end up 
waiting on select forever and never getting woken up.  The 0.07 driver 
changes wait queue and lvi handling in a few strategic places, so it 
should work.  However, it's untested.  Reports welcome.

Complete c file: http://people.redhat.com/dledford/i810_audio.c.gz

-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

