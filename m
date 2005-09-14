Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030241AbVINQWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030241AbVINQWA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 12:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbVINQWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 12:22:00 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:48645 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1030237AbVINQV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 12:21:58 -0400
Message-ID: <43284DD0.5080709@tmr.com>
Date: Wed, 14 Sep 2005 12:20:32 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "liyu@WAN" <liyu@ccoss.com.cn>
CC: Linux-newbie@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Problem booting 2.6.13 on RHEL 4
References: <b115cb5f05091321082a3ffc24@mail.gmail.com> <4327DBBB.7090108@ccoss.com.cn>
In-Reply-To: <4327DBBB.7090108@ccoss.com.cn>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

liyu@WAN wrote:
> 
> It seem that kernel have no time to probe your disk, and do not
> read parttion table.
> 
> I use kernel 2.6.12 and SATA disk on FC3, also failed to boot.
> but after some experiment, I found if we place 'sleep 5'
> statement between insmod commands in linuxrc or init, it will
> boot up!
> 
> However, this idea is too HACK.

It would have been nice, back in the 2.5.46 timeframe when modules were 
complete reinvented, to have provided a hook by which modprobe could 
have waited until insertion init was complete.

The sleep is a hack indeed, as is the slightly more reliable solution to 
tail the log and look for init messages to appear. Perhaps look for the 
devices in /proc/scsi/scsi or something?

There doesn't seem to be a "right way" for this, particularly if you 
have both warm and cold boots, which may differ by minutes depending on 
disk spin-up already being done.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

