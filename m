Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131076AbRCREr1>; Sat, 17 Mar 2001 23:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131151AbRCRErH>; Sat, 17 Mar 2001 23:47:07 -0500
Received: from dfw-smtpout2.email.verio.net ([129.250.36.42]:54935 "EHLO
	dfw-smtpout2.email.verio.net") by vger.kernel.org with ESMTP
	id <S131076AbRCRErB>; Sat, 17 Mar 2001 23:47:01 -0500
Message-ID: <3AB43D9B.64CAB5C@bigfoot.com>
Date: Sat, 17 Mar 2001 20:46:19 -0800
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.19pre17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
Subject: Re: [PATCH] /proc/uptime on SMP machines
In-Reply-To: <15027.62364.751528.388435@siemens.ikp.physik.tu-darmstadt.de> <3AB42E58.1FF1895F@bigfoot.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch works on 2.2.19pre17.  The second machine (asus) has Uwe's patch modified for 2.2.  The
machine 'smp' is not patched.

rgds,
tim.

[tim@smp ~]# cat /proc/uptime ; cat /proc/stat | grep cpu ; yes > /dev/null & ; sleep 180 ; killall
yes ; cat /proc/uptime ; cat /proc/stat | grep cpu
[2] 1485
22689.88 21324.40
cpu  175685 0 32321 4329972
cpu0 121396 0 15195 2132398
cpu1 54289 0 17126 2197574
Terminated
22869.90 21324.40
cpu  193551 0 33066 4347365
cpu0 139179 0 15414 2132398
cpu1 54372 0 17652 2214967
[2]  - Exit 143                      ( cat /proc/uptime; cat /proc/stat | grep cpu; yes > /dev/null
)

[tim@asus ~]# date ; cat /proc/uptime ; cat /proc/stat | grep cpu ; yes > /dev/null & ; sleep 180 ;
killall yes ; cat /proc/uptime ; cat /proc/stat | grep cpu
[1] 870
Sat Mar 17 20:41:49 PST 2001
3260.19 2337.13
cpu  174676 0 9849 467515
cpu0 90385 0 4666 230969
cpu1 84291 0 5183 236546
Terminated
3440.20 2424.73
cpu  192352 0 10656 485034
cpu0 108059 0 4992 230970
cpu1 84293 0 5664 254064
[1]  + Exit 143                      ( date; cat /proc/uptime; cat /proc/stat | grep cpu; yes >
/dev/null )
[tim@asus ~]# cat /proc/version
Linux version 2.2.19pre17 (root@asus) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release))
#5 SMP Sat Mar 17 19:44:42 PST 2001

--
