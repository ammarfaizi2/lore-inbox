Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264313AbTKZUsL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 15:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264324AbTKZUsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 15:48:11 -0500
Received: from out006pub.verizon.net ([206.46.170.106]:17807 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S264313AbTKZUrb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 15:47:31 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: amanda vs 2.6
Date: Wed, 26 Nov 2003 15:47:30 -0500
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <200311261212.10166.gene.heskett@verizon.net> <200311261523.33524.gene.heskett@verizon.net> <20031126203231.GV8039@holomorphy.com>
In-Reply-To: <20031126203231.GV8039@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311261547.30183.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [151.205.54.127] at Wed, 26 Nov 2003 14:47:30 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 November 2003 15:32, William Lee Irwin III wrote:
>On Wednesday 26 November 2003 14:50, William Lee Irwin III wrote:
>>> Okay, then we need to figure out what the hung process was doing.
>>> Can you find its pid and check /proc/$PID/wchan?
>
>On Wed, Nov 26, 2003 at 03:23:33PM -0500, Gene Heskett wrote:
>> Ok, repeat, us is PID 1843, so:
>> [root@coyote root]# ps -ea|grep su
>>  1843 pts/1    00:00:00 su
>> [root@coyote root]# cat /proc/1843/wchan
>> sys_wait4[root@coyote root]#
>> Unforch, echoing a 0 to that variable doesn't fix it, reboot time
>> again.
>> Do you need my .config?
>
>su had apparently spawned something and is waiting on it in the
>wchan you showed. Could you find the shell it spawned as an amanda
>user and syslogd (as per Linus' suggestion) also?

I need a bottle of aspirin, no change, but this boot, its working.  Go 
figure.  FWIW, syslogd is running just fine, or is for this boot 
anyway...  At this point I don't even have a SWAG about whats going 
on.

Besides, that was a shell I typed that into, and I don't believe it 
actually spawned the users shell.  No visible indicator that I could 
see.

>-- wli

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

