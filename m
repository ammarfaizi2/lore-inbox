Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264308AbTKZUXh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 15:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264311AbTKZUXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 15:23:37 -0500
Received: from out004pub.verizon.net ([206.46.170.142]:21160 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S264308AbTKZUXf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 15:23:35 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: amanda vs 2.6
Date: Wed, 26 Nov 2003 15:23:33 -0500
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <200311261212.10166.gene.heskett@verizon.net> <200311261443.43695.gene.heskett@verizon.net> <20031126195049.GT8039@holomorphy.com>
In-Reply-To: <20031126195049.GT8039@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311261523.33524.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [151.205.54.127] at Wed, 26 Nov 2003 14:23:33 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 November 2003 14:50, William Lee Irwin III wrote:
>On Wednesday 26 November 2003 14:30, William Lee Irwin III wrote:
>>> Sounds like trouble. Are there any external signs of what's going
>>> on? e.g. is the disk thrashing?
>
>On Wed, Nov 26, 2003 at 02:43:43PM -0500, Gene Heskett wrote:
>> No, it just hangs forever on the su command, never coming back.
>> everything else I tried, which wasn't much, seemed to keep on
>> working as I sent that message with that hung su process in
>> another shell on another window.  I'm an idiot, normally running
>> as root... I've rebooted, not knowing if an echo 0 to that
>> variable would fix it or not, I see after the reboot the default
>> value is 0 now.
>
>Okay, then we need to figure out what the hung process was doing.
>Can you find its pid and check /proc/$PID/wchan?
>
Ok, repeat, us is PID 1843, so:
[root@coyote root]# ps -ea|grep su
 1843 pts/1    00:00:00 su
[root@coyote root]# cat /proc/1843/wchan
sys_wait4[root@coyote root]#

Unforch, echoing a 0 to that variable doesn't fix it, reboot time 
again.

Do you need my .config?

>
>-- wli

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

