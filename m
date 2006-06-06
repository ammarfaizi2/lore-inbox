Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbWFFHKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWFFHKW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 03:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbWFFHKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 03:10:22 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:7517 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932130AbWFFHKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 03:10:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Fxx1BfgSQ+8p8x9N6ghieoxwqEjwnRaKiBDHO+lAcTB+JmXS/eI/b/0Eetj2U/2aW4nIAcSWOBD0JfWNMWyWSQ21dWIUVcRsqePJO2+G7KFI7j3bOT9VXYLtvhV7YKsGuVNkUb8Lq5L8fyH6g6YcFnF8WUS3tinpmgR8oz5R+vs=
Message-ID: <44852A53.6050204@gmail.com>
Date: Tue, 06 Jun 2006 16:10:11 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Robert Hancock <hancockr@shaw.ca>, Bill Davidsen <davidsen@tmr.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [git patch] libata resume fix
References: <6hAdo-5CV-5@gated-at.bofh.it> <6hXD0-6Y9-1@gated-at.bofh.it> <6icsx-4vp-33@gated-at.bofh.it> <6ih8Y-3ba-15@gated-at.bofh.it> <6iH3h-2xw-59@gated-at.bofh.it> <447E5EAD.5070808@shaw.ca> <20060601134802.GK4400@suse.de> <4485269B.8060602@gmail.com> <20060606070539.GO4400@suse.de>
In-Reply-To: <20060606070539.GO4400@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
>> Can you measure spin up time for your 15k's?  Some controllers can't 
>> catch the first D2H FIS after POR and have to wait unconditionally for 
>> spin up for hotplug & resuming from suspend.  Currently 8 sec wait is 
>> used but it seems insufficient for your drives.  Failing to spinup in 
>> that 8 secs would probably result in timeout of the first reset attempt 
>> and retrial - which currently takes > 30 secs.
>>
>> Spin-up time can be measured by first issuing STANDBY and then time how 
>> long IDLE IMMEDIATE takes, I think.
> 
> The 15K RPM is a SCSI drive, I haven't seen any SATA 15K rpm drives yet.
> I have the same model in another box, I can measure spinup with
> START_STOP unit there. I will do so later today, when I fire it up, if
> you still want to know?
> 

Arggh.. Confused w/ 10k drives.  But it would be nice to know spin-up 
time for 15k's if it doesn't waste too much of your time.

Thanks.

-- 
tejun
