Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129784AbQLVRdV>; Fri, 22 Dec 2000 12:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129842AbQLVRdB>; Fri, 22 Dec 2000 12:33:01 -0500
Received: from pm3-13-34.dial.stratos.net ([207.86.135.34]:23796 "EHLO
	mobile.torri.linux") by vger.kernel.org with ESMTP
	id <S129784AbQLVRc6>; Fri, 22 Dec 2000 12:32:58 -0500
Date: Fri, 22 Dec 2000 17:01:02 +0000 (GMT)
From: Stephen Torri <s.torri@lancaster.ac.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Transmission errors for Xircom RealPort2 10/100 Cardbus NIC.
Message-ID: <Pine.LNX.4.21.0012221649060.1705-100000@mobile.torri.linux>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having a real interesting time with the Xircom card and
kernel-2.2.16. All transmission packets from the NIC are being flagged for
errors while all received packets are fine. The card is in a Twinhead
P88TE Cardbus PCMCIA slot. Eradicate errors like total packet loss, 1
packet out of 4 returning fine with ping, and others are causing me to be
concerned. The module I am using is tulip_cb.

I got these details from ifconfig.

eth0      Link encap:Ethernet  HWaddr 00:10:A4:B9:6C:D2  
          inet addr:10.0.0.4  Bcast:10.0.0.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:965 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:983 dropped:0 overruns:0 carrier:983
          collisions:0 txqueuelen:100 
          Interrupt:3 Base address:0x100 

I checked the file /proc/net/dev
Inter-|   Receive                                                |  Transmit
 face |bytes    packets errs drop fifo frame compressed multicast|bytes    packets errs drop fifo colls carrier compressed
    lo:  613871    2002    0    0    0     0          0         0   613871    2002    0    0    0     0       0          0
  eth0:  597544    1017    0    0    0     0          0         0        0       0 1038    0    0     0    1038          0

That reports no errors.

Just to let you know what modules are loaded:

Module                  Size  Used by
tulip_cb               30856   2 
cb_enabler              2472   2  [tulip_cb]
ds                      6600   2  [cb_enabler]
i82365                 29764   2 
pcmcia_core            44192   0  [cb_enabler ds i82365]
nls_cp437               3876   3  (autoclean)
vfat                    9276   1  (autoclean)
fat                    30400   1  (autoclean) [vfat]
es1371                 27264   0 
soundcore               2628   4  [es1371]

Stephen
-- 
Buyer's Guide for a Operating System:
Don't care to know: Mac
Don't mind knowing but not too much: Windows
Hit me! I can take it!: Linux

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
