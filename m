Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261366AbTCaCLG>; Sun, 30 Mar 2003 21:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261367AbTCaCLG>; Sun, 30 Mar 2003 21:11:06 -0500
Received: from mail.gmx.de ([213.165.65.60]:41283 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261366AbTCaCLE>;
	Sun, 30 Mar 2003 21:11:04 -0500
Message-Id: <5.2.0.9.2.20030331042453.00cee3a8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Mon, 31 Mar 2003 04:26:55 +0200
To: Michal Schmidt <schmidt@kn.vutbr.cz>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: Reproducible terrible interactivity since 2.5.64bk2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3E8774FA.7070209@kn.vutbr.cz>
References: <5.2.0.9.2.20030328181731.01997810@pop.gmx.net>
 <1048687681.6345.13.camel@spinel.tao.co.uk>
 <3E81945C.4010102@kn.vutbr.cz>
 <1048687681.6345.13.camel@spinel.tao.co.uk>
 <5.2.0.9.2.20030328181731.01997810@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:51 AM 3/31/2003 +0200, Michal Schmidt wrote:
>Mike Galbraith wrote:
>>Greetings potential victims :)
>>Care to see if the attached cures your woes?
>>This is a mixture of Ingo's last posted plus the scheduler tuning knobs 
>>patch (/proc/sys/sched/*).  I added three new knobs to watch the effect 
>>on different loads.  max_accel_slices limits the amount of sleep_time you 
>>may add in one activation.  retard_prct_slices is a percentage of a slice 
>>to deduct from sleep_time each activation (negative feedback for heavy 
>>context switchers.. dang irman process_load).  force_switch is there 
>>because I'm playing :)  I didn't do much to the scheduler itself, only 
>>made it switch arrays in something closer to a square wave.  With the 
>>settings as in the patch, and running a kernel build, top and irman, 
>>irman reports worst case response times of 150ms for NULL load, 316ms for 
>>memory_load, 414 for io_load, and 504ms for process_load.
>>Anyway, it's attached if you want to play with it ;-)
>>         -Mike
>>Oh, it's against virgin 2.5.66.
>
>
>Thanks, running 2.5.66 with the patch applied I could no more reproduce 
>the problem. I haven't tried playing with the knobs.

Thanks for the info.

         -Mike

