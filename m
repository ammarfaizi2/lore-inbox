Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283599AbRLDXog>; Tue, 4 Dec 2001 18:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283588AbRLDXo0>; Tue, 4 Dec 2001 18:44:26 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:17695 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S280357AbRLDXoJ>; Tue, 4 Dec 2001 18:44:09 -0500
Message-ID: <3C0D5FC7.3040408@redhat.com>
Date: Tue, 04 Dec 2001 18:44:07 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011129
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nathan Bryant <nbryant@optonline.net>
CC: Mario Mikocevic <mozgy@hinet.hr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i810 audio patch
In-Reply-To: <3C0C16E7.70206@optonline.net> <3C0C508C.40407@redhat.com> <3C0C58DE.9020703@optonline.net> <3C0C5CB2.6000602@optonline.net> <3C0C61CC.1060703@redhat.com> <20011204153507.A842@danielle.hinet.hr> <3C0D1DD2.4040609@optonline.net> <3C0D223E.3020904@redhat.com> <3C0D350F.9010408@optonline.net> <3C0D3CF7.6030805@redhat.com> <3C0D4E62.4010904@optonline.net> <3C0D52F1.5020800@optonline.net> <3C0D5796.6080202@redhat.com> <3C0D5CB6.1080600@optonline.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Bryant wrote:

> Doug Ledford wrote:
> 
>> Yes, on underrun the DAC is stopped and dmabuf->enable is cleared. 
>> That's clearly a bug in this case.  However, it should only cause your 
>> problem if you are in fact getting an underrun.  Anyway, here's a 
>> proposed fix you can try to see if that's what's causing the problem:
> 
> 
> [snip]
> 
> That works.


OK, good.  I've fixed another bug related to MMAPed stuff (for the 
people that like to play Quake on these sound cards).  I've put up a 
0.08 version of the file on my web page.  If people could please verify 
that this version works for them I would appreciate it.  Once I've 
gotten a few "It works here" reports and no "It blew my computer up" 
reports, I'll submit it to Marcello and Linus so we can finally get 
these things working a bit more reliably.

Highlights of this release:

Fix GETOPTR and GETIPTR (thinko/typo in an if statement)
Fix i810_poll() (side effect of fixing overrun/underrun handling in 0.06)
Make handling of dmabuf->trigger more consistent throughout the source code

http://people.redhat.com/dledford/i810_audio.c.gz





-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

