Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262227AbVCODz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbVCODz6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 22:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbVCODz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 22:55:58 -0500
Received: from washoe.rutgers.edu ([165.230.95.67]:25516 "EHLO
	washoe.rutgers.edu") by vger.kernel.org with ESMTP id S262227AbVCODzo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 22:55:44 -0500
Date: Mon, 14 Mar 2005 22:55:44 -0500
From: Yaroslav Halchenko <kernel@onerussian.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: tired of wireless + WEP... uff
Message-ID: <20050315035543.GI3114@washoe.rutgers.edu>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-URL: http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: 3BB6 E124 0643 A615 6F00  6854 8D11 4563 75C0 24C8
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Kernel People

Please advise... Long ago when I didn't use WEP I had my intenal (Network controller: Intersil Corporation: Unknown device 3872) and pcmcia belkin F5D6020
(probably version 1) working as charm wo tweeking (although I thought I
had to set RTS to 256 or call cardctl reset from time to time...)

Then I moved to Netgear WG511 using prism54 driver. Everything was
working well till (after some of the upgrades around 2.6.7-8) it start
freezing up my laptop completely. Although SysRq combination still can
reboot it, nothing else works. First I thought that it has something to
do with hardware (I got inside the laptop couple of times either to fix
LCD or touchpad or fan) because it seem to coincide with movement of
laptop -- I move it and it dies... but it died couple of times without
any physical effect... also it doesn't die with other kinds of pcmcia
wireless cards but died with the same model when I exchanged it...

Then I switched to my internal card and I came back to issues which
seems to be general for my laptop and pcmcia orinoco cards because I've
tried belkin as well and after 1-2 minutes of work they start start
reporting

Mar 14 21:56:28 localhost kernel: eth3: Error -16 transmitting packet
Mar 14 21:56:28 localhost kernel: hermes @ IO 0x100: Error -16 issuing command.

syslog and cardmgr become busy as hell... laptop becomes useless...

I had to take Belkin card away from slot but here are some details:
(I'm running 2.6.11.3 at the moment)

eth3: Station identity 001f:0003:0000:0008
eth3: Looks like an Intersil firmware version 0.8.3
eth3: Ad-hoc demo mode supported
eth3: IEEE standard IBSS ad-hoc mode supported
eth3: WEP supported, 104-bit key
eth3: MAC address 00:30:BD:61:20:D9
eth3: Station name "Prism  I"
eth3: ready
eth3: index 0x01: Vcc 5.0, irq 3, io 0x0100-0x013f
eth3: New link status: Connected (0001)



Socket 0:
  product info: "Belkin", "11Mbps Wireless Notebook Network Adapter", "Version 01.02", ""
  manfid: 0x0156, 0x0002
  function: 6 (network)
Socket 0:
  dev_info
    NULL 0ns, 512b
  attr_dev_info
    SRAM 500ns, 1kb
  vers_1 5.0, "Belkin", "11Mbps Wireless Notebook Network Adapter",
    "Version 01.02", ""
  manfid 0x0156, 0x0002
  funcid network_adapter
  lan_technology wireless
  lan_speed 1 mb/sec
  lan_speed 2 mb/sec
  lan_speed 5 mb/sec
  lan_speed 11 mb/sec
  lan_media 2.4_GHz
  lan_node_id 00 30 bd 61 20 d9
  lan_connector Closed connector standard
  config base 0x03e0 mask 0x0001 last_index 0x01
  cftable_entry 0x01 [default]
    Vcc Vmin 4750mV Vmax 5250mV Iavg 300mA Ipeak 300mA
    Idown 10mA
    io 0x0000-0x003f [lines=6] [16bit]
    irq mask 0xffff [level] [pulse]

Please advise on where to look for reasons of this weird behavior... I
want to be friendly with WEP :-)


-- 
                                                  Yaroslav Halchenko
                  Research Assistant, Psychology Department, Rutgers
          Office  (973) 353-5440 x263  Fax (973) 353-1171
   Ph.D. Student  CS Dept. NJIT

