Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264240AbSIQO64>; Tue, 17 Sep 2002 10:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264245AbSIQO64>; Tue, 17 Sep 2002 10:58:56 -0400
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:23501 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S264240AbSIQO6z>; Tue, 17 Sep 2002 10:58:55 -0400
Message-ID: <3D8744CA.6090300@drugphish.ch>
Date: Tue, 17 Sep 2002 17:05:46 +0200
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kirk Reiser <kirk@braille.uwo.ca>
Cc: Skip Ford <skip.ford@verizon.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.35 undefined reference to `wait_task_inactive'
References: <200209160644.g8G6iEvo006691@pool-141-150-241-241.delv.east.verizon.net> <x7sn08k7r0.fsf@speech.braille.uwo.ca> <3D87422B.3080300@drugphish.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roberto Nibali wrote:
>>> A call to wait_task_inactive was added to fs/exec.c but that function is
>>> not defined for UP.
>>
>> I haven't seen a fix for this yet?  
> 
> 
> Err, I've done and sent a possible patch to LKML, I'm simply not sure if 
> this is the right thing to do:
> 
> --- linux-2.5.35/kernel/sched.c Mon Sep 16 04:18:24 2002
> +++ linux-2.5.35-ratz/kernel/sched.c    Mon Sep 16 13:29:28 2002
> @@ -331,8 +331,6 @@

Actually the correct fix seems to be already in Linus' tree:

ChangeSet@1.564, 2002-09-15 22:53:19-07:00, david@gibson.dropbear.id.au
   [PATCH] Remove CONFIG_SMP around wait_task_inactive()

So after all, my patch wasn't all that wrong, just a little ... ;).

As it seems also the ieee1394 patches went in and the USB storage 
compilation problem is also fixed.

Best regards,
Roberto Nibali, ratz
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc

