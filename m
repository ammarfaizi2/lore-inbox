Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965137AbVHPH4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965137AbVHPH4z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 03:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965138AbVHPH4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 03:56:54 -0400
Received: from [145.253.159.150] ([145.253.159.150]:43672 "EHLO
	mail.ponton-consulting.de") by vger.kernel.org with ESMTP
	id S965137AbVHPH4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 03:56:54 -0400
Message-ID: <43019C3D.4060705@ponton-consulting.de>
Date: Tue, 16 Aug 2005 09:56:45 +0200
From: Nicholas Fechner <fechner@ponton-consulting.de>
Organization: Ponton Consulting GmbH
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Module bridge not loading in 2.6.13-rc6
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC to fechner@ponton-consulting.de, since I am not subscribed to
linux-kernel. Thanks.

Hi,
I tried the current -rc6 Release on one of our test machines. It is a
mirror of our gateway, hence the iptable modules. It also runs OpenVPN
using a bridge configuration. After the kernel build and reboot I tried
to "modprobe bridge", resulting in:

FATAL: Error inserting bridge
(/lib/modules/2.6.13-rc6/kernel/net/bridge/bridge.ko): Unknown symbol in
module, or unknown parameter (see dmesg)

If you need any more information, I will be happy to supply.
Thanks,
Nicholas Fechner



Output from lsmod:
Module                  Size  Used by
tun                    11776  0
ipt_MASQUERADE          3584  1
ipt_iprange             1920  1
ipt_state               2048  3
iptable_filter          3200  1
ipt_ULOG                8196  1
ip_nat_irc              2816  0
ip_nat_ftp              3584  0
iptable_nat            23892  4 ipt_MASQUERADE,ip_nat_irc,ip_nat_ftp
ip_conntrack_irc       72080  1 ip_nat_irc
ip_conntrack_ftp       73104  1 ip_nat_ftp
ip_conntrack           44952  7
ipt_MASQUERADE,ipt_state,ip_nat_irc,ip_nat_ftp,iptable_nat,ip_conntrack_irc,ip_conntrack_ftp
ip_tables              20736  6
ipt_MASQUERADE,ipt_iprange,ipt_state,iptable_filter,ipt_ULOG,iptable_nat
i2c_i801                9100  0
i2c_core               21392  1 i2c_i801
evdev                   9472  0
psmouse                35332  0



Output of dmesg (relevant part plus a little bit before that):
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard on isa0060/serio0
IP route cache hash table entries: 8192 (order: 3, 32768 bytes)
TCP established hash table entries: 32768 (order: 6, 262144 bytes)
TCP bind hash table entries: 32768 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
XFS mounting filesystem sda2
Ending clean XFS mount for filesystem: sda2
VFS: Mounted root (xfs filesystem) readonly.
Freeing unused kernel memory: 156k freed
Adding 1951856k swap on /dev/sda1.  Priority:-1 extents:1
logips2pp: Detected unknown logitech mouse model 1
input: PS/2 Logitech Mouse on isa0060/serio1
e1000: eth0: e1000_watchdog_task: NIC Link is Up 100 Mbps Full Duplex
e100: eth1: e100_watchdog: link up, 100Mbps, full-duplex
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 216 bytes per conntrack
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
bridge: disagrees about version of symbol dev_set_mtu
bridge: Unknown symbol dev_set_mtu
bridge: disagrees about version of symbol dev_queue_xmit
bridge: Unknown symbol dev_queue_xmit
bridge: Unknown symbol br_handle_frame_hook
bridge: disagrees about version of symbol unregister_netdev
bridge: Unknown symbol unregister_netdev
bridge: disagrees about version of symbol dev_alloc_name
bridge: Unknown symbol dev_alloc_name
bridge: disagrees about version of symbol ___pskb_trim
bridge: Unknown symbol ___pskb_trim
bridge: disagrees about version of symbol dev_set_promiscuity
bridge: Unknown symbol dev_set_promiscuity
bridge: disagrees about version of symbol nf_unregister_hook
bridge: Unknown symbol nf_unregister_hook
bridge: disagrees about version of symbol __dev_get_by_name
bridge: Unknown symbol __dev_get_by_name
bridge: disagrees about version of symbol ether_setup
bridge: Unknown symbol ether_setup
bridge: disagrees about version of symbol skb_under_panic
bridge: Unknown symbol skb_under_panic
bridge: Unknown symbol br_fdb_put_hook
bridge: disagrees about version of symbol skb_over_panic
bridge: Unknown symbol skb_over_panic
bridge: disagrees about version of symbol dev_get_by_index
bridge: Unknown symbol dev_get_by_index
bridge: disagrees about version of symbol dev_base
bridge: Unknown symbol dev_base
bridge: disagrees about version of symbol netif_receive_skb
bridge: Unknown symbol netif_receive_skb
bridge: disagrees about version of symbol free_netdev
bridge: Unknown symbol free_netdev
bridge: disagrees about version of symbol alloc_skb
bridge: Unknown symbol alloc_skb
bridge: disagrees about version of symbol __pskb_pull_tail
bridge: Unknown symbol __pskb_pull_tail
bridge: disagrees about version of symbol nf_hook_slow
bridge: Unknown symbol nf_hook_slow
bridge: disagrees about version of symbol nf_register_hook
bridge: Unknown symbol nf_register_hook
bridge: disagrees about version of symbol alloc_netdev
bridge: Unknown symbol alloc_netdev
bridge: disagrees about version of symbol skb_clone
bridge: Unknown symbol skb_clone
bridge: Unknown symbol br_fdb_get_hook
bridge: disagrees about version of symbol ip_route_output_key
bridge: Unknown symbol ip_route_output_key
bridge: disagrees about version of symbol unregister_netdevice
bridge: Unknown symbol unregister_netdevice
bridge: disagrees about version of symbol ip_route_input
bridge: Unknown symbol ip_route_input
bridge: disagrees about version of symbol __kfree_skb
bridge: Unknown symbol __kfree_skb
bridge: disagrees about version of symbol register_netdevice
bridge: Unknown symbol register_netdevice

Output from lspci:
0000:00:00.0 Host bridge: Intel Corp. 82875P Memory Controller Hub (rev 02)
0000:00:03.0 PCI bridge: Intel Corp. 82875P Processor to PCI to CSA
Bridge (rev 02)
0000:00:1c.0 PCI bridge: Intel Corp. 6300ESB 64-bit PCI-X Bridge (rev 02)
0000:00:1d.0 USB Controller: Intel Corp. 6300ESB USB Universal Host
Controller (rev 02)
0000:00:1d.1 USB Controller: Intel Corp. 6300ESB USB Universal Host
Controller (rev 02)
0000:00:1d.4 System peripheral: Intel Corp. 6300ESB Watchdog Timer (rev 02)
0000:00:1d.5 PIC: Intel Corp. 6300ESB I/O Advanced Programmable
Interrupt Controller (rev 02)
0000:00:1d.7 USB Controller: Intel Corp. 6300ESB USB2 Enhanced Host
Controller (rev 02)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 0a)
0000:00:1f.0 ISA bridge: Intel Corp. 6300ESB LPC Interface Controller
(rev 02)
0000:00:1f.1 IDE interface: Intel Corp. 6300ESB PATA Storage Controller
(rev 02)
0000:00:1f.2 IDE interface: Intel Corp. 6300ESB SATA Storage Controller
(rev 02)
0000:00:1f.3 SMBus: Intel Corp. 6300ESB SMBus Controller (rev 02)
0000:01:01.0 Ethernet controller: Intel Corp. 82547GI Gigabit Ethernet
Controller
0000:03:00.0 VGA compatible controller: ATI Technologies Inc Rage XL
(rev 27)
0000:03:01.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro
100] (rev 10)

Output from uname -a:
Linux atlas 2.6.13-rc6 #1 Tue Aug 16 08:35:19 CEST 2005 i686 GNU/Linux

