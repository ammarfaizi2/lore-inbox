Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbTKVQT2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 11:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbTKVQT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 11:19:28 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:41145 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S262353AbTKVQTY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 11:19:24 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: anand@eis.iisc.ernet.in (SVR Anand), linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9 : bridge freezes
Date: Sat, 22 Nov 2003 11:19:21 -0500
User-Agent: KMail/1.5.1
Cc: linux-net@vger.kernel.org
References: <200311221527.UAA29684@eis.iisc.ernet.in>
In-Reply-To: <200311221527.UAA29684@eis.iisc.ernet.in>
Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311221119.21978.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [151.205.54.127] at Sat, 22 Nov 2003 10:19:23 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 22 November 2003 10:27, SVR Anand wrote:
>Hi,
>
>I am one of the system administrators who manage a campus network of
> 5000 users that is connected to Internet. We have placed a Linux
> bridge to isolate the Internet from the campus. To nullify network
> flooding effect, we have used iptables. The kernel is 2.6.0-test9,
> the ethernet cards that are used are RTL8139.
>
>The problem is : After 3 to 4 hours of functioning, the bridge stops
> working and the machine becomes unusable where it doesn't respond
> to keyboard, and there is no video display. In simple terms it
> freezes. Before going in for 2.6.0-test9 I have tried 2.4.20 with
> bridge patches for iptables support. It worked reliably except that
> I cannot even login from the console because I don't get the shell
> prompt after a while.
>
>Presently I have gone back to 2.4.20 for the sake of robustness. Can
> someone let me know what I can do to use 2.6.x kernel with a good
> amount of confidence so that I can keep the campus users happy ? I
> am making guess work as to whether the problem is with the network
> drivers, or some power management issues, and so on.
>
>Any inputs from you will be really useful. I am eager to try out any
> amount of debugging, the thing is I don't know what to look for.

Neither do I, but I can report that iptables is apparently stable, 
witness this from my firewall machine:
---------------------
[root@gene root]# uname -a
Linux gene.coyote.den 2.4.21-rc1-ck6 #9 Mon May 5 23:31:30 EDT 2003 
i586 unknown
[root@gene root]# uptime
 11:14am  up 35 days,  3:19,  2 users,  load average: 1.00, 1.00, 1.00
---------------------
Now admittedly it doesn't have 5000 users, just one.  But everytime 
I'd had problems such as you are describing at the tv station the 
where user count is about 65, its hardware related. I'd start by 
letting memtest86 run on that box for a couple of days, maybe it will 
find some flakey memory.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

