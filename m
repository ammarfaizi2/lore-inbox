Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264730AbTE1NSE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 09:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264731AbTE1NSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 09:18:03 -0400
Received: from pop.gmx.net ([213.165.64.20]:9673 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264730AbTE1NRg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 09:17:36 -0400
Message-ID: <3ED4BA09.9040108@gmx.net>
Date: Wed, 28 May 2003 15:30:49 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Jens Axboe <axboe@suse.de>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Andrew Morton <akpm@digeo.com>, matthias.mueller@rz.uni-karlsruhe.de,
       manish@storadinc.com, andrea@suse.de, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
References: <3ED2DE86.2070406@storadinc.com> <3ED4B49A.4050001@gmx.net> <20030528130839.GW845@suse.de> <200305282321.45405.kernel@kolivas.org>
In-Reply-To: <200305282321.45405.kernel@kolivas.org>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Wed, 28 May 2003 23:08, Jens Axboe wrote:
> 
>>On Wed, May 28 2003, Carl-Daniel Hailfinger wrote:
>>
>>>Jens Axboe wrote:
>>>
>>>>On Wed, May 28 2003, Marc-Christian Petersen wrote:
>>>>
>>>>>On Wednesday 28 May 2003 13:27, Andrew Morton wrote:
>>>>>
>>>>>>Guys, you're the ones who can reproduce this.  Please spend more time
>>>>>>working out which chunk (or combination thereof) actually fixes the
>>>>>>problem.  If indeed any of them do.
>>>>>
>>>>>As I said, I will test it this evening. ATM I don't have time to
>>>>>recompile and reboot. This evening I will test extensively, even on
>>>>>SMP, SCSI, IDE and so on.
>>>>
>>>>May I ask how you are reproducing the bad results? I'm trying in vain
>>>>here...
>>>
>>>Quoting Con Kolivas:
>>>
>>>dd if=/dev/zero of=dump bs=4096 count=512000
>>
>>already tried that, no go. on ide/scsi? what filesystem? how much ram?
>>anything else running? smp/up?
> 
> 
> I'm using UP on IDE. I reproduce it easily on a P3 256Mb laptop with 5400rpm 
> drive, and less easily but still occurs on a P4 2.53 512Mb pc with 2x7200rpm 
> software raid 0 IDE drives. Even if the only thing you try to do is move the 
> mouse, the mouse will freeze for up to 30secs. When you first start the write 
> no disk activity happens for up to a few seconds, then it will start writing 
> madly and the machine will come to a standstill for a variable length of 
> time. Then it will come back to life for a few seconds only to die again for 
> a few seconds and so on till the write is complete.
> 
> Still testing combinations to see which is the best, but 1+2 seems better than 
> 3 alone as doing reads midstream in the write don't cause hangs. I haven't 
> seen zombie processes ever.

Just curious - which compiler did you use?


Carl-Daniel

