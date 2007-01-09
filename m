Return-Path: <linux-kernel-owner+w=401wt.eu-S932566AbXAIX7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbXAIX7j (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 18:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbXAIX7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 18:59:38 -0500
Received: from mga01.intel.com ([192.55.52.88]:17276 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932555AbXAIX7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 18:59:33 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.13,164,1167638400"; 
   d="scan'208"; a="186364366:sNHT26096203"
Message-ID: <45A42C62.2030309@intel.com>
Date: Tue, 09 Jan 2007 15:59:30 -0800
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.9 (X11/20061228)
MIME-Version: 1.0
To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
       7atbggg02@sneakemail.com
CC: Jeb Cramer <cramerj@intel.com>, John Ronciak <john.ronciak@intel.com>,
       Jesse Brandeburg <jesse.brandeburg@intel.com>,
       Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Subject: Re: e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
References: <20070109222708.GA15510@m.safari.iki.fi>
In-Reply-To: <20070109222708.GA15510@m.safari.iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sami Farin wrote:
> Linux 2.6.19.1 SMP on Pentium D, Intel DQ965GF mobo.
> Got this while bittorrenting knoppix:
> 
> 2007-01-09 22:53:40.020693500 <4>NETFILTER drop IN=eth0 OUT= MAC=00:19:d1:00:5f:01:00:05:00:1c:58:1c:08:00 SRC=83.46.5.76 DST=80.223.106.128 LEN=121 TOS=0x00 PREC=0x00 TTL=112 ID=53273 PROTO=ICMP TYPE=3 CODE=3 [SRC=80.223.106.128 DST=192.168.1.37 LEN=93 TOS=0x00 PREC=0x00 TTL=45 ID=0 DF PROTO=UDP SPT=6881 DPT=6895 LEN=73 ] 
> 2007-01-09 22:53:41.660249500 <3>e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
> 2007-01-09 22:53:41.660253500 <4>  Tx Queue             <0>
> 2007-01-09 22:53:41.660254500 <4>  TDH                  <3c>
> 2007-01-09 22:53:41.660255500 <4>  TDT                  <ca>
> 2007-01-09 22:53:41.660255500 <4>  next_to_use          <ca>
> 2007-01-09 22:53:41.660256500 <4>  next_to_clean        <3c>
> 2007-01-09 22:53:41.660257500 <4>buffer_info[next_to_clean]
> 2007-01-09 22:53:41.660258500 <4>  time_stamp           <8c3b8e4>
> 2007-01-09 22:53:41.660259500 <4>  next_to_watch        <3f>
> 2007-01-09 22:53:41.660274500 <4>  jiffies              <8c3bf13>
> 2007-01-09 22:53:41.660275500 <4>  next_to_watch.status <0>
> 2007-01-09 22:53:42.660365500 <3>e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
> 2007-01-09 22:53:42.660368500 <4>  Tx Queue             <0>
> 2007-01-09 22:53:42.660369500 <4>  TDH                  <3c>
> 2007-01-09 22:53:42.660370500 <4>  TDT                  <ca>
> 2007-01-09 22:53:42.660370500 <4>  next_to_use          <ca>
> 2007-01-09 22:53:42.660371500 <4>  next_to_clean        <3c>
> 2007-01-09 22:53:42.660372500 <4>buffer_info[next_to_clean]
> 2007-01-09 22:53:42.660373500 <4>  time_stamp           <8c3b8e4>
> 2007-01-09 22:53:42.660374500 <4>  next_to_watch        <3f>
> 2007-01-09 22:53:42.660389500 <4>  jiffies              <8c3c2fb>
> 2007-01-09 22:53:42.660390500 <4>  next_to_watch.status <0>
> 2007-01-09 22:53:43.660086500 <3>e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
> 2007-01-09 22:53:43.660089500 <4>  Tx Queue             <0>
> 2007-01-09 22:53:43.660090500 <4>  TDH                  <3c>
> 2007-01-09 22:53:43.660091500 <4>  TDT                  <ca>
> 2007-01-09 22:53:43.660092500 <4>  next_to_use          <ca>
> 2007-01-09 22:53:43.660093500 <4>  next_to_clean        <3c>
> 2007-01-09 22:53:43.660093500 <4>buffer_info[next_to_clean]
> 2007-01-09 22:53:43.660094500 <4>  time_stamp           <8c3b8e4>
> 2007-01-09 22:53:43.660095500 <4>  next_to_watch        <3f>
> 2007-01-09 22:53:43.660110500 <4>  jiffies              <8c3c6e3>
> 2007-01-09 22:53:43.660111500 <4>  next_to_watch.status <0>
> 2007-01-09 22:53:44.660001500 <3>e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
> 2007-01-09 22:53:44.660004500 <4>  Tx Queue             <0>
> 2007-01-09 22:53:44.660005500 <4>  TDH                  <3c>
> 2007-01-09 22:53:44.660006500 <4>  TDT                  <ca>
> 2007-01-09 22:53:44.660007500 <4>  next_to_use          <ca>
> 2007-01-09 22:53:44.660008500 <4>  next_to_clean        <3c>
> 2007-01-09 22:53:44.660009500 <4>buffer_info[next_to_clean]
> 2007-01-09 22:53:44.660009500 <4>  time_stamp           <8c3b8e4>
> 2007-01-09 22:53:44.660010500 <4>  next_to_watch        <3f>
> 2007-01-09 22:53:44.660026500 <4>  jiffies              <8c3cacb>
> 2007-01-09 22:53:44.660027500 <4>  next_to_watch.status <0>
> 2007-01-09 22:53:45.659906500 <3>e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
> 2007-01-09 22:53:45.659909500 <4>  Tx Queue             <0>
> 2007-01-09 22:53:45.659909500 <4>  TDH                  <3c>
> 2007-01-09 22:53:45.659910500 <4>  TDT                  <ca>
> 2007-01-09 22:53:45.659911500 <4>  next_to_use          <ca>
> 2007-01-09 22:53:45.659912500 <4>  next_to_clean        <3c>
> 2007-01-09 22:53:45.659913500 <4>buffer_info[next_to_clean]
> 2007-01-09 22:53:45.659914500 <4>  time_stamp           <8c3b8e4>
> 2007-01-09 22:53:45.659915500 <4>  next_to_watch        <3f>
> 2007-01-09 22:53:45.659930500 <4>  jiffies              <8c3ceb3>
> 2007-01-09 22:53:45.659931500 <4>  next_to_watch.status <0>
> 2007-01-09 22:53:46.659784500 <3>e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
> 2007-01-09 22:53:46.659787500 <4>  Tx Queue             <0>
> 2007-01-09 22:53:46.659788500 <4>  TDH                  <3c>
> 2007-01-09 22:53:46.659788500 <4>  TDT                  <ca>
> 2007-01-09 22:53:46.659789500 <4>  next_to_use          <ca>
> 2007-01-09 22:53:46.659790500 <4>  next_to_clean        <3c>
> 2007-01-09 22:53:46.659791500 <4>buffer_info[next_to_clean]
> 2007-01-09 22:53:46.659792500 <4>  time_stamp           <8c3b8e4>
> 2007-01-09 22:53:46.659793500 <4>  next_to_watch        <3f>
> 2007-01-09 22:53:46.659807500 <4>  jiffies              <8c3d29b>
> 2007-01-09 22:53:46.659808500 <4>  next_to_watch.status <0>
> 2007-01-09 22:53:47.130361500 <6>NETDEV WATCHDOG: eth0: transmit timed out
> 2007-01-09 22:53:48.771500500 <6>e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
> 2007-01-09 22:53:54.838031500 <4>NETFILTER drop IN=eth0 OUT= MAC=00:19:d1:00:5f:01:00:05:00:1c:58:1c:08:00 SRC=84.49.68.15 DST=80.223.106.128 LEN=56 TOS=0x00 PREC=0x00 TTL=142 ID=55046 PROTO=ICMP TYPE=3 CODE=1 [SRC=80.223.106.128 DST=10.0.0.2 LEN=91 TOS=0x00 PREC=0x00 TTL=48 ID=0 DF PROTO=UDP SPT=6881 DPT=4412 LEN=71 ] 
> 
> ...and...
> 
> 2007-01-09 23:40:42.311352500 <4>NETFILTER drop IN=eth0 OUT= MAC=00:19:d1:00:5f:01:00:05:00:1c:58:1c:08:00 SRC=81.205.87.93 DST=80.223.106.128 LEN=40 TOS=0x00 PREC=0x00 TTL=242 ID=65259 PROTO=TCP SPT=10763 DPT=6881 WINDOW=16680 RES=0x00 RST URGP=0 
> 2007-01-09 23:40:45.895636500 <3>e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
> 2007-01-09 23:40:45.895659500 <4>  Tx Queue             <0>
> 2007-01-09 23:40:45.895660500 <4>  TDH                  <be>
> 2007-01-09 23:40:45.895661500 <4>  TDT                  <88>
> 2007-01-09 23:40:45.895662500 <4>  next_to_use          <88>
> 2007-01-09 23:40:45.895663500 <4>  next_to_clean        <be>
> 2007-01-09 23:40:45.895664500 <4>buffer_info[next_to_clean]
> 2007-01-09 23:40:45.895664500 <4>  time_stamp           <8eed1ae>
> 2007-01-09 23:40:45.895665500 <4>  next_to_watch        <c2>
> 2007-01-09 23:40:45.895666500 <4>  jiffies              <8eed719>
> 2007-01-09 23:40:45.895672500 <4>  next_to_watch.status <0>
> 2007-01-09 23:40:46.895583500 <3>e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
> 2007-01-09 23:40:46.895608500 <4>  Tx Queue             <0>
> 2007-01-09 23:40:46.895609500 <4>  TDH                  <be>
> 2007-01-09 23:40:46.895610500 <4>  TDT                  <88>
> 2007-01-09 23:40:46.895611500 <4>  next_to_use          <88>
> 2007-01-09 23:40:46.895612500 <4>  next_to_clean        <be>
> 2007-01-09 23:40:46.895613500 <4>buffer_info[next_to_clean]
> 2007-01-09 23:40:46.895614500 <4>  time_stamp           <8eed1ae>
> 2007-01-09 23:40:46.895615500 <4>  next_to_watch        <c2>
> 2007-01-09 23:40:46.895616500 <4>  jiffies              <8eedb01>
> 2007-01-09 23:40:46.895621500 <4>  next_to_watch.status <0>
> 2007-01-09 23:40:47.895425500 <3>e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
> 2007-01-09 23:40:47.895450500 <4>  Tx Queue             <0>
> 2007-01-09 23:40:47.895451500 <4>  TDH                  <be>
> 2007-01-09 23:40:47.895452500 <4>  TDT                  <88>
> 2007-01-09 23:40:47.895453500 <4>  next_to_use          <88>
> 2007-01-09 23:40:47.895454500 <4>  next_to_clean        <be>
> 2007-01-09 23:40:47.895455500 <4>buffer_info[next_to_clean]
> 2007-01-09 23:40:47.895456500 <4>  time_stamp           <8eed1ae>
> 2007-01-09 23:40:47.895457500 <4>  next_to_watch        <c2>
> 2007-01-09 23:40:47.895458500 <4>  jiffies              <8eedee9>
> 2007-01-09 23:40:47.895470500 <4>  next_to_watch.status <0>
> 2007-01-09 23:40:47.896794500 <4>NETFILTER drop IN=eth0 OUT= MAC=00:19:d1:00:5f:01:00:05:00:1c:58:1c:08:00 SRC=72.66.121.37 DST=80.223.106.128 LEN=64 TOS=0x00 PREC=0x60 TTL=111 ID=20866 DF PROTO=TCP SPT=62965 DPT=52075 WINDOW=65535 RES=0x00 ACK SYN URGP=0 OPT (020405AC010303000101080A000000000000000001010402) 
> 2007-01-09 23:40:48.895296500 <3>e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
> 2007-01-09 23:40:48.895321500 <4>  Tx Queue             <0>
> 2007-01-09 23:40:48.895323500 <4>  TDH                  <be>
> 2007-01-09 23:40:48.895324500 <4>  TDT                  <88>
> 2007-01-09 23:40:48.895325500 <4>  next_to_use          <88>
> 2007-01-09 23:40:48.895325500 <4>  next_to_clean        <be>
> 2007-01-09 23:40:48.895326500 <4>buffer_info[next_to_clean]
> 2007-01-09 23:40:48.895327500 <4>  time_stamp           <8eed1ae>
> 2007-01-09 23:40:48.895328500 <4>  next_to_watch        <c2>
> 2007-01-09 23:40:48.895329500 <4>  jiffies              <8eee2d1>
> 2007-01-09 23:40:48.895334500 <4>  next_to_watch.status <0>
> 2007-01-09 23:40:49.895227500 <3>e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
> 2007-01-09 23:40:49.895252500 <4>  Tx Queue             <0>
> 2007-01-09 23:40:49.895253500 <4>  TDH                  <be>
> 2007-01-09 23:40:49.895254500 <4>  TDT                  <88>
> 2007-01-09 23:40:49.895255500 <4>  next_to_use          <88>
> 2007-01-09 23:40:49.895256500 <4>  next_to_clean        <be>
> 2007-01-09 23:40:49.895257500 <4>buffer_info[next_to_clean]
> 2007-01-09 23:40:49.895257500 <4>  time_stamp           <8eed1ae>
> 2007-01-09 23:40:49.895258500 <4>  next_to_watch        <c2>
> 2007-01-09 23:40:49.895259500 <4>  jiffies              <8eee6b9>
> 2007-01-09 23:40:49.895265500 <4>  next_to_watch.status <0>
> 2007-01-09 23:40:50.896148500 <3>e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
> 2007-01-09 23:40:50.896173500 <4>  Tx Queue             <0>
> 2007-01-09 23:40:50.896174500 <4>  TDH                  <be>
> 2007-01-09 23:40:50.896175500 <4>  TDT                  <88>
> 2007-01-09 23:40:50.896176500 <4>  next_to_use          <88>
> 2007-01-09 23:40:50.896177500 <4>  next_to_clean        <be>
> 2007-01-09 23:40:50.896178500 <4>buffer_info[next_to_clean]
> 2007-01-09 23:40:50.896179500 <4>  time_stamp           <8eed1ae>
> 2007-01-09 23:40:50.896180500 <4>  next_to_watch        <c2>
> 2007-01-09 23:40:50.896180500 <4>  jiffies              <8eeeaa2>
> 2007-01-09 23:40:50.896186500 <4>  next_to_watch.status <0>
> 2007-01-09 23:40:51.896064500 <3>e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
> 2007-01-09 23:40:51.896087500 <4>  Tx Queue             <0>
> 2007-01-09 23:40:51.896089500 <4>  TDH                  <be>
> 2007-01-09 23:40:51.896090500 <4>  TDT                  <88>
> 2007-01-09 23:40:51.896090500 <4>  next_to_use          <88>
> 2007-01-09 23:40:51.896091500 <4>  next_to_clean        <be>
> 2007-01-09 23:40:51.896092500 <4>buffer_info[next_to_clean]
> 2007-01-09 23:40:51.896093500 <4>  time_stamp           <8eed1ae>
> 2007-01-09 23:40:51.896094500 <4>  next_to_watch        <c2>
> 2007-01-09 23:40:51.896104500 <4>  jiffies              <8eeee8a>
> 2007-01-09 23:40:51.896105500 <4>  next_to_watch.status <0>
> 2007-01-09 23:40:52.895896500 <3>e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
> 2007-01-09 23:40:52.895919500 <4>  Tx Queue             <0>
> 2007-01-09 23:40:52.895921500 <4>  TDH                  <be>
> 2007-01-09 23:40:52.895921500 <4>  TDT                  <88>
> 2007-01-09 23:40:52.895922500 <4>  next_to_use          <88>
> 2007-01-09 23:40:52.895923500 <4>  next_to_clean        <be>
> 2007-01-09 23:40:52.895924500 <4>buffer_info[next_to_clean]
> 2007-01-09 23:40:52.895925500 <4>  time_stamp           <8eed1ae>
> 2007-01-09 23:40:52.895926500 <4>  next_to_watch        <c2>
> 2007-01-09 23:40:52.895927500 <4>  jiffies              <8eef271>
> 2007-01-09 23:40:52.895958500 <4>  next_to_watch.status <0>
> 2007-01-09 23:40:53.808906500 <6>NETDEV WATCHDOG: eth0: transmit timed out
> 2007-01-09 23:40:55.405688500 <6>e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
> 2007-01-09 23:41:09.222382500 <4>NETFILTER drop IN=eth0 OUT= MAC=00:19:d1:00:5f:01:00:05:00:1c:58:1c:08:00 SRC=220.233.94.69 DST=80.223.106.128 LEN=56 TOS=0x00 PREC=0x00 TTL=46 ID=9052 DF PROTO=ICMP TYPE=3 CODE=3 [SRC=80.223.106.128 DST=220.233.94.69 LEN=91 TOS=0x00 PREC=0x20 TTL=43 ID=0 FRAG:64 PROTO=UDP ] 
> 
> # ethtool -k eth0
> Offload parameters for eth0:
> rx-checksumming: on
> tx-checksumming: on
> scatter-gather: on
> tcp segmentation offload: on
> 
> # ethtool eth0
> Settings for eth0:
>         Supported ports: [ TP ]
>         Supported link modes:   10baseT/Half 10baseT/Full 
>                                 100baseT/Half 100baseT/Full 
>                                 1000baseT/Full 
>         Supports auto-negotiation: Yes
>         Advertised link modes:  10baseT/Half 10baseT/Full 
>                                 100baseT/Half 100baseT/Full 
>                                 1000baseT/Full 
>         Advertised auto-negotiation: Yes
>         Speed: 100Mb/s
>         Duplex: Full
>         Port: Twisted Pair
>         PHYAD: 0
>         Transceiver: internal
>         Auto-negotiation: on
>         Supports Wake-on: umbg
>         Wake-on: g
>         Current message level: 0x00000007 (7)
>         Link detected: yes
> 
> # modinfo e1000|grep ^version
> version:        7.2.9-k4-NAPI
> 
> # cat /proc/interrupts 
>            CPU0       CPU1       
>   0:   76199639   76208855   IO-APIC-edge      timer
>   1:          2          0   IO-APIC-edge      i8042
>   7:          0          0   IO-APIC-edge      parport0
>   8:          3          0   IO-APIC-edge      rtc
>   9:          0          0   IO-APIC-fasteoi   acpi
>  12:          4          0   IO-APIC-edge      i8042
>  16:      12696      13034   IO-APIC-fasteoi   ide2, serial
>  17:    4755669    4755794   IO-APIC-fasteoi   uhci_hcd:usb3, i915@pci:0000:00:02.0
>  18:          0          0   IO-APIC-fasteoi   ehci_hcd:usb1, uhci_hcd:usb7
>  19:     556145     559038   IO-APIC-fasteoi   uhci_hcd:usb6, ohci1394
>  20:          3          0   IO-APIC-fasteoi   ehci_hcd:usb2, uhci_hcd:usb5
>  21:          0          0   IO-APIC-fasteoi   uhci_hcd:usb4
> 216:   11572166          0   PCI-MSI-edge      eth0
> 217:    6328596    6334001   PCI-MSI-edge      HDA Intel
> 218:    1542147    1517971   PCI-MSI-edge      libata
> NMI:          0          0 
> LOC:  150901361  150902242 
> ERR:          0
> MIS:          0
> 
> I do "ethtool -K eth0 tso off" now and check if I get the hang again. =)

I'm unsure whether v7.2.x already automatically disables TSO for 100mbit speed link, 
probably not. It should.

Please try our updated driver from http://e1000.sf.net/ (7.3.20) against the same 
kernel. There are some changes with regard to the ich8/TSO driver that might affect 
this, so re-testing is worth it for us.

also, please always include the full dmesg output. Feel free to CC 
e1000-devel@lists.sourceforge.net on this.

Auke
