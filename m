Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262625AbUCEPlI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 10:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262627AbUCEPlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 10:41:08 -0500
Received: from pD9E14F87.dip.t-dialin.net ([217.225.79.135]:14731 "EHLO
	laura.nettrade.de") by vger.kernel.org with ESMTP id S262625AbUCEPlC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 10:41:02 -0500
Date: Fri, 5 Mar 2004 16:40:59 +0100 (MET)
From: Matthias Jim Knopf <jim@users.de>
Reply-To: jim999@gmx.net
To: linux-kernel@vger.kernel.org
Subject: Problems with WLAN orinoco_pci
In-Reply-To: <200403050144.17622.dtor_core@ameritech.net>
Message-ID: <Pine.LNX.4.21.0403051606520.1685-100000@laura.nettrade.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

My WLAN net goes down from time to time. I cannot ping the wlan/dsl-router
(T-Sinus 111) and the only thing that helps is re-load the kernel-driver
(ifconfig eth1 down; modprobe -r orinoco_pci;
 sleep 8; ifconfig eth1 up; iwconfig ...)

Changing speed (down to 1 Mb/s) does no better

Bisides this, I have annother problem: This f***ing router mentioned
above cannot handle at least one connection per second in the long run
(>30 minutes) and crashes in the way, that it still may be pinged, but
I cannot access the router's web-interface, nor can I get to the internet
and have to power-cyle it (official advice from the company selling it!)
I tried hard to see these problems as one, but it seems, they ARE
two (see logs)


Here is, what I can offer you as info:
WLAN is a Netgear PCI MA311 (using hermes, orinoco)

# iwconfig
eth1      IEEE 802.11-DS  ESSID:"WLAN"  Nickname:"jim"
          Mode:Managed  Frequency:2.437GHz  Access Point: 00:30:F1:xx:xx:xx
          Bit Rate:11Mb/s   Tx-Power=15 dBm   Sensitivity:1/3
          Retry min limit:8   RTS thr:off   Fragment thr:off
          Encryption key:xxxx-xxxx-xx   Security mode:open
          Power Management:off
          Link Quality:20/92  Signal level:-76 dBm  Noise level:-136 dBm
          Rx invalid nwid:0  Rx invalid crypt:0  Rx invalid frag:1
          Tx excessive retries:2  Invalid misc:0   Missed beacon:0

# ping -c 5 router
PING wlan-router (192.168.2.1): 56 data bytes
--- wlan-router ping statistics ---
5 packets transmitted, 0 packets received, 100% packet loss

# uname -a
Linux laura 2.4.22 #2 Sun Dec 21 17:14:01 MET 2003 i686 unknown

# lsmod
Module                  Size  Used by
orinoco_pci             3056   1  (autoclean)
orinoco                31808   0  (autoclean) [orinoco_pci]
hermes                  5232   0  (autoclean) [orinoco_pci orinoco]
[...]

---{ /var/log/warn }----------------------------------------------------------------------------
Mar  5 15:41:43 laura kernel: eth1: Error -110 writing Tx descriptor to BAP
Mar  5 15:42:15 laura last message repeated 59 times
Mar  5 15:42:22 laura last message repeated 12 times
[...]
Mar  5 15:44:34 laura kernel: eth1: error -110 reading info frame. Frame dropped.
Mar  5 15:44:34 laura kernel: eth1: Error -110 writing Tx descriptor to BAP
Mar  5 15:44:41 laura last message repeated 14 times
Mar  5 15:45:33 laura kernel: .....<7>orinoco_lock() called with hw_unavailable (dev=e3c82800)
Mar  5 15:45:33 laura kernel: ......<7>orinoco_lock() called with hw_unavailable (dev=e3c82800)
Mar  5 15:45:33 laura last message repeated 4 times
Mar  5 15:45:33 laura kernel: .....<7>orinoco_lock() called with hw_unavailable (dev=e3c82800)
Mar  5 15:45:33 laura kernel: ......<7>orinoco_lock() called with hw_unavailable (dev=e3c82800)
Mar  5 15:45:33 laura last message repeated 4 times
Mar  5 15:45:34 laura kernel: .........;
[...]
------------------------------------------------------------------------------------------------


Thanks in advance for any help you can give me!

Matthias


-- 
EOF


