Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261653AbREZWny>; Sat, 26 May 2001 18:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261407AbREZWno>; Sat, 26 May 2001 18:43:44 -0400
Received: from femail4.rdc1.on.home.com ([24.2.9.91]:23748 "EHLO
	femail4.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S261264AbREZWnZ>; Sat, 26 May 2001 18:43:25 -0400
Date: Sat, 26 May 2001 18:35:56 -0500
X-Mailer: 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid (via feedmail 9-beta-7 I);
	VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15120.15836.154821.236021@viper.earth>
From: "S.Salman Ahmed" <ssahmed@pathcom.com>
To: linux-kernel@vger.kernel.org
Subject: System lockups with 2.4.4/2.4.5 (rtl8139 perhaps?)
Reply-To: ssahmed@pathcom.com
X-No-Archive: Yes
X-Operating-System: Linux viper 2.4.5 i686
X-Organization: Salman Ahmed Software & Consulting
X-Disclaimer: I didn't do it, little green aliens wrote this email
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(I am not subscribed to the linux-kernel, so please CC: me on all
replies). 

I have two machines, both are currently running 2.4.5. I am consistently
able to lockup the machine (desktop) from which I try to scp a file over
to the machine (headless firewall) running the OpenSSH server.

Both machines are connected using a crossover cable, which is connected
between two D-Link 530TX+ NICs using the rtl8139 driver. On the two
systems, the NICs are identified as:

(on the headless firewall running the OpenSSH server)

eth1: RealTek RTL8139 Fast Ethernet at 0xc8800000, 00:50:ba:44:8a:ab, IRQ 11
eth1:  Identified 8139 chip type 'RTL-8139B'
eth1: Setting 100mbps full-duplex based on auto-negotiated partner ability 41e1.

(on the desktop machine - which isn't running the OpenSSH server - from
which I am trying to scp over files to the above system):

eth0: RealTek RTL8139 Fast Ethernet at 0xd1006000, 00:50:ba:44:70:ce, IRQ 9
eth0:  Identified 8139 chip type 'RTL-8139B'
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 41e1.

Both machines have the following version of OpenSSH installed:

OpenSSH_2.5.2p2, SSH protocols 1.5/2.0, OpenSSL 0x0090601f

Both machines are running Debian sid/unstable with kernel 2.4.5,
libc6-2.2.3-4 compiled using the following version of gcc:

Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
gcc version 2.95.4 20010506 (Debian prerelease)

Server machine running the OpenSSH server is a Celeron300A based
system. The Desktop machine (which locks up) is a PIII-933 based
system w/ an ASUS CUSL2 mobo and an UDMA100 Maxtor HD.

If I switch back to kernel 2.4.3, this problem goes away and I can scp
files back and forth b/w these 2 machines wo any problem. But the
lockups persist with 2.4.4 and 2.4.5. As far as I can remember, I wasn't
having this problem at all before 2.4.3.

The size of the file being scp-ed seems to matter. Small files ie under
200K or so seem to be copied without any problems. Bigger files cause
the desktop system to lockup hard (SysRq keys don't work). The server
machine is unaffected.

I have a suspicion that this problem has something to do with the
rtl8139 driver since I have a couple of Debian sid/unstable boxes at
work running 2.4.4 which don't have rtl8139-based NICs, and scping back
and forth between these boxes does not cause any lockup at all.

If any additional information is required, I'll be happy to oblige. In
the meantime, I will be downgrading to 2.4.3.

Thanks for any help and assistance.

-- 
Salman Ahmed
ssahmed AT pathcom DOT com

