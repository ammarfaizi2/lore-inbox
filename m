Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262594AbTDAPZx>; Tue, 1 Apr 2003 10:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262597AbTDAPZx>; Tue, 1 Apr 2003 10:25:53 -0500
Received: from franka.aracnet.com ([216.99.193.44]:14217 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262594AbTDAPZw>; Tue, 1 Apr 2003 10:25:52 -0500
Date: Tue, 01 Apr 2003 07:37:12 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 528] New: In /proc/net/route the default gateway isn't appear
Message-ID: <22810000.1049211432@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=528

           Summary: In /proc/net/route the default gateway isn't appear
    Kernel Version: 2.5.66
            Status: NEW
          Severity: low
             Owner: davem@vger.kernel.org
         Submitter: szazol@e98.hu


Distribution:
   Debian woody

Hardware Environment:
   IBM Thinpad T21 Pentium III (Coppermine)

Software Environment:
   Kernel 2.5.66 compiled with gcc-3.2
   ip utility, iproute2-ss010824

Problem Description:

In /proc/net/route the default gateway isn't appear:

$ netstat -rn
Kernel IP routing table
Destination     Gateway         Genmask         Flags   MSS Window  irtt Iface
xx.x.xx.x       0.0.0.0         xxx.xxx.xxx.0   U         0 0          0 eth0

$ cat /proc/net/route
Iface   Destination     Gateway         Flags   RefCnt  Use     Metric  Mask   
        MTU     Window  IRTT                                                       
eth0    xxxxxxxx        00000000        0001    0       0       0       xxxxxxxx
       0       0       0                            

But:

$ ip route show
xx.x.xx.x/xx dev eth0  proto kernel  scope link  src xx.x.xx.xxx
default via xx.x.xx.x dev eth0


