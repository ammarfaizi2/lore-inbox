Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269940AbUJNAlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269940AbUJNAlp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 20:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269939AbUJNAlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 20:41:45 -0400
Received: from smtp06.auna.com ([62.81.186.16]:8121 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S269938AbUJNAla convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 20:41:30 -0400
Date: Thu, 14 Oct 2004 00:41:25 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: eth1394 performace
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: bcollins@debian.org, linux1394-devel@lists.sourceforge.net,
       linux1394-user@lists.sourceforge.net
X-Mailer: Balsa 2.2.5
Message-Id: <1097714485l.6634l.1l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

I'm trying to link an iBook and my linux box (kernel 2.6.9-rc4-mm1) via FireWire.
With static IP addresses, it seems to work, but performance is sloow (compared
to what I expected;):

werewolf:/usr/src/linux# iperf -c ibook
------------------------------------------------------------
Client connecting to ibook, TCP port 5001
TCP window size: 16.0 KByte (default)
------------------------------------------------------------
[  3] local 192.168.0.1 port 33155 connected with 192.168.0.2 port 5001
[ ID] Interval       Transfer     Bandwidth
[  3]  0.0-10.0 sec   110 MBytes  91.8 Mbits/sec
werewolf:/usr/src/linux# iperf -c ibook-fw
------------------------------------------------------------
Client connecting to ibook-fw, TCP port 5001
TCP window size: 16.0 KByte (default)
------------------------------------------------------------
[  3] local 192.168.1.1 port 33156 connected with 192.168.1.2 port 5001
[ ID] Interval       Transfer     Bandwidth
[  3]  0.0-10.0 sec  90.5 MBytes  75.8 Mbits/sec

Subnet 192.168.0 is an ethernet link (e1000 -> iBook), and 192.168.1
is the firewire one.

Hardware:
03:03.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)

Modules:
eth1394                18952  0 
e1000                  78516  0 
ohci1394               29700  0 

(iee1394 is compiled-in).

Where did I lost my 400Mb/s ?

TIA

(Please, people in the 1394 lists, CC me, I'm not subscribed. Thanks.)

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Community) for i586
Linux 2.6.9-rc4-mm1 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #3


