Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262941AbVGNH1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262941AbVGNH1Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 03:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262940AbVGNH1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 03:27:15 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:21223 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S262939AbVGNH1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 03:27:13 -0400
From: Grant Coady <x0x0x@dodo.com.au>
To: Jesse Brandeburg <jesse.brandeburg@gmail.com>
Cc: Mikhail Kshevetskiy <kl@laska.dorms.spbu.ru>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: eepro100/e100 broken in 2.6.13-rc3
Date: Thu, 14 Jul 2005 17:26:59 +1000
Organization: www.scatter.mine.nu
Message-ID: <5p4cd190d9l39tcvt28j69p84747u1crfb@4ax.com>
References: <20050714034954.52947263@laska> <4807377b05071323286963bf3a@mail.gmail.com>
In-Reply-To: <4807377b05071323286963bf3a@mail.gmail.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2005 23:28:15 -0700, Jesse Brandeburg <jesse.brandeburg@gmail.com> wrote:

>On 7/13/05, Mikhail Kshevetskiy <kl@laska.dorms.spbu.ru> wrote:
>> symptom
>> =======
>> modprobe e100
>> ifconfig eth0 <ip> netmask <netmask>
>> 
>> result:
>> =======
>> SIOCADDRT: Network is unreachable
>> 
>> There were no such error in 2.6.13-rc2
>
peetoo:~$ uname -r
2.6.13-rc3-a
peetoo:~$ lspci
00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03)
00:07.0 ISA bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 02)
00:0d.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] (rev 08)
00:0e.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] (rev 08)
00:0f.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 [FasterNet] (rev 22)
01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC AGP (rev 7a)
peetoo:~$ lsmod
Module                  Size  Used by
adm9240                16056  0
i2c_sensor              2816  1 adm9240
radio_aztech            4316  0
nfsd                   92296  5
exportfs                4576  1 nfsd
tulip                  42496  0
e100                   30656  0
usb_storage            30276  0
peetoo:~$ ifconfig
eth0      Link encap:Ethernet  HWaddr 00:90:27:58:EC:6F
          inet addr:192.168.1.24  Bcast:192.168.1.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:3454075 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1759340 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:826224238 (787.9 Mb)  TX bytes:99642515 (95.0 Mb)

eth1      Link encap:Ethernet  HWaddr 00:04:AC:F3:4B:84
          inet addr:192.168.3.24  Bcast:192.168.3.255  Mask:255.255.255.0
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

eth2      Link encap:Ethernet  HWaddr 00:00:E8:4A:A0:C8
          inet addr:192.168.4.24  Bcast:192.168.4.255  Mask:255.255.255.0
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
          Interrupt:5 Base address:0x8000

Not broken here :)
--Grant.

