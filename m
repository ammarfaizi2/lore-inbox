Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbVHWJKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbVHWJKc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 05:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbVHWJKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 05:10:32 -0400
Received: from smtp3.netcologne.de ([194.8.194.66]:22168 "EHLO
	smtp3.netcologne.de") by vger.kernel.org with ESMTP id S932101AbVHWJKb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 05:10:31 -0400
Message-ID: <430AE85E.5040002@mch.one.pl>
Date: Tue, 23 Aug 2005 11:11:58 +0200
From: Tomasz Chmielewski <mangoo@mch.one.pl>
User-Agent: Mozilla Thunderbird 1.0.6-3mdk (X11/20050322)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: mass "tulip_stop_rxtx() failed", network stops
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are running almost 20 Fujitsu-Siemens Scenic machines, 2.6.8.1 
kernel, equipped with a onboard card that uses a tulip module:

02:01.0 Ethernet controller: Linksys NC100 Network Everywhere Fast 
Ethernet 10/100 (rev 11)

No problem with those.


We are running four more machines like that, the only difference is the 
kernel they are running (2.6.11.4).

On some of them, there are serious problems with a network, and they 
usually happen when the traffic is bigger than usual (i.e., some big 
software deployment to several workstations, remote backup, etc.).

The syslog is then full of entries like that:

Aug 21 04:04:30 SERVER-B-HS kernel: NETDEV WATCHDOG: eth0: transmit 
timed out
Aug 21 04:04:30 SERVER-B-HS kernel: 0000:00:06.0: tulip_stop_rxtx() failed

and it's filling logs for hours; network doesn't work anymore, and 
someone has to restart the network or the machine itself.

It doesn't always happen with a big traffic - sometimes you can fill the 
100 Mbit link and do lots of reads from the disk, but nothing bad 
happens for hours.


I saw some posts on this issue ("2.6.10-rc3: tulip-driver: 
tulip_stop_rxtx() failed"), but it seemed to me that it wasn't similar 
to my problems; I looked into >2.6.10 kernel changelog, but there were 
no descriptions of that problem, either.


Any help appreciated, because rebooting machines which are 500 km away 
and are not responding is no fun :)


-- 
Tomek
http://wpkg.org

