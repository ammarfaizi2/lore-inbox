Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262207AbTIMVha (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 17:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbTIMVha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 17:37:30 -0400
Received: from spoetnik.kulnet.kuleuven.ac.be ([134.58.240.46]:8168 "EHLO
	spoetnik.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S262207AbTIMVh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 17:37:28 -0400
Message-ID: <3F638E18.9080406@abcpages.com>
Date: Sat, 13 Sep 2003 23:37:28 +0200
From: Nicolae Mihalache <mache@abcpages.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Patrick Mochel <mochel@osdl.org>
Subject: Re: 2.6-test4 problems: suspend and touchpad
References: <Pine.LNX.4.33.0309121519420.984-100000@localhost.localdomain> <3F637245.9070009@abcpages.com>
In-Reply-To: <3F637245.9070009@abcpages.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolae Mihalache wrote:

 > Patrick Mochel wrote:
 >
 >>> 2. suspend/resume. With version 2.6test2+acpi patch both swsusp and
 >>> "echo 3 >/proc/acpi/sleep" worked, being able to somehow
 >>> successfully resume. In version 2.6test4 there is no
 >>> /proc/acpi/sleep and swsusp hangs somwhere during an IDE call (I can
 >>> hand-copy the trace if needed).
 >>>
 >>
 >>
 >> Would you please try the latest -mm patch (2.6.0-test5-mm1, I
 >> believe) and report your findings?
 >>
 >
 > Well, the 2.6.0-test5-mm1 does not compile on my system (SuSE 8.2, gcc
 > version 3.3 20030226 (prerelease) ):

Ok, I solved the compilation problems and with this kernel swsusp does 
not hang anymore.
The resume works however the network adapter (Broadcom 4400) does not 
even when restarting the network.
ifconfig eth0 shows very big counters:
eth0      Link encap:Ethernet  HWaddr 00:C0:9F:26:C7:15
          UP BROADCAST NOTRAILERS RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:819 errors:4294966560 dropped:0 overruns:0 
frame:4294966836
          TX packets:865 errors:4294966836 dropped:0 overruns:0 
carrier:4294967118
          collisions:4294967204 txqueuelen:100
          RX bytes:956732 (934.3 Kb)  TX bytes:89228 (87.1 Kb)
          Interrupt:5


Any ideas? Maybe the driver for this network card does not (correctly) 
implement suspend/resume ?
mache



