Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129106AbRCHPVv>; Thu, 8 Mar 2001 10:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129078AbRCHPVc>; Thu, 8 Mar 2001 10:21:32 -0500
Received: from mail.t-intra.de ([62.156.146.210]:65414 "EHLO mail.t-intra.de")
	by vger.kernel.org with ESMTP id <S129072AbRCHPV1>;
	Thu, 8 Mar 2001 10:21:27 -0500
Message-Id: <200103081519.f28FJ9u05622@gate2.private.net>
From: "Otto Meier" <gf435@gmx.net>
To: "Neil Brown" <neilb@cse.unsw.edu.au>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
Date: Thu, 08 Mar 2001 16:19:50 +0100
Reply-To: "otto meier" <gf435@gmx.net>
X-Mailer: PMMail 2000 Professional (2.10.2010) For Windows 98 (4.10.2222)
In-Reply-To: <15014.44624.26763.798524@notabene.cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: Kernel crash during resync of raid5 on SMP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Mar 2001 08:55:28 +1100 (EST), Neil Brown wrote:

>On Wednesday March 7, gf435@gmx.net wrote:
>> I run a Dual prozessor SMP system on 2.4.2-ac12 for a while
>> in degraded mode. Today I put in a new disk to switch to
>> full raid5 mode. Shortly after the command raidhotadd  the 
>> system crashed with the message lost interrupt on cpu1.
>
>Was there an Oops? Can we see? decoded with ksymoops of course.

Unfortunatly I entered this command remotely. The console Display was
off at that time.

>Are you happy to retry? (i.e. raidsetfaulty; raidhotremove,
>raidhotadd).  If so, Could you try with 2.4.2?

I would not really like to do that, as of now everything runs fine again for a day.

>Where abouts in the sync-process did it die?  Start? end? middle?
>various?

After the first crash I needed to reboot. It crashed again shortly after
boot message that it starts to resync.

This happens several times until I used the kernel parameter MAXcpus=1.
Then it worked without a problem. After resyncing finished I could start
it again in SMP mode and everything worked fine again.

Sorry that can not shed any more light on it.

Otto


>NeilBrown
>
>
>> 
>> This continued after reboot. I finaly managed to get it running again
>> by booting with kernel parameter maxcpus=1. In this one CPU mode
>> it finished resycing. 
>> 
>> During this process I was never able to resync with two CPU's.
>> 
>> After finishing rescyncing the system run now fine in SMP Dual mode again.
>> 
>> Perhaps there might be an issue with spinlocks during resyncing.
>> 
>> Bye Otto
>> 
>> 
>> 
>> 
>> 
>> 
>



