Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267706AbTGHVk7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 17:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267707AbTGHVk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 17:40:59 -0400
Received: from dsl-gte-19434.linkline.com ([64.30.195.78]:34688 "EHLO server")
	by vger.kernel.org with ESMTP id S267706AbTGHVkb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 17:40:31 -0400
Message-ID: <020301c3459b$942a1860$3400a8c0@W2RZ8L4S02>
From: "Jim Gifford" <maillist@jg555.com>
To: "Marcelo Tosatti" <marcelo@conectiva.com.br>
Cc: "lkml" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.55L.0307052151180.21992@freak.distro.conectiva> <003501c34572$4113f0c0$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307081551480.21543@freak.distro.conectiva>
Subject: Re: Linux 2.4.22-pre3
Date: Tue, 8 Jul 2003 14:36:05 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Marcelo Tosatti" <marcelo@conectiva.com.br>
To: "Jim Gifford" <maillist@jg555.com>
Cc: "lkml" <linux-kernel@vger.kernel.org>
Sent: Tuesday, July 08, 2003 1:38 PM
Subject: Re: Linux 2.4.22-pre3


>
> Are you using SMP? What drivers are you using and what your workload is?
>
> On Tue, 8 Jul 2003, Jim Gifford wrote:
>
> > Still receiving lockups. It it is about 2 days and 10 hours before the
> > system just freezes. I can use the sysrq keys to safely shutdown. No
error
> > messages present in any logs.
> >
> > As I stated in previous emails, when I run sync every hour, this
prevents
> > the lock ups. I will try this under the 2.4.22-pre3.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Here is in the information you requested, probably more than you need.

Running a Dell Poweredge 4200 with 2 Pentium II 333 with a Dell
Perc2(Megaraid) and adaptec. 1GB of ECC/EDO RAM. Adaptec 6922 Network
Adapter

Using Megaraid Driver 1.18i (from lsi logic's web site)
Using Adaptec Driver included in pre3.
Using Tulip driver for ethernet included in pre3
Using usb-ohci driver for usb included in pre3
Utilizing ext3 file system on 3 logical drives.

Server is a multi-purpose box. Apache, Courier Mail, Proftp, and SSH. (ran
on version 2.4.19 with no issues, problems started with 2.4.20.)

Compiled using GCC 3.3.

Here is the procinfo information. With all services running.

Linux 2.4.22-pre3 (root@server) (gcc 3.3) #1 SMP Tue Jul 8 12:17:09 PDT 2003
2CPU [server.jg555.com]

Memory:      Total        Used        Free      Shared     Buffers
Cached
Mem:       1033680      224568      809112           0       13604
60280
Swap:      1060280           0     1060280

Bootup: Tue Jul  8 14:05:29 2003    Load average: 3.19 3.15 2.47 8/114 22182

user  :       0:17:49.33  34.6%  page in :    67027  disk 1:     1563r
3187w
nice  :       0:24:10.61  46.9%  page out:    76204  disk 2:     2202r
1396w
system:       0:06:05.34  11.8%  swap in :        1  disk 3:     3377r
1780w
idle  :       0:03:26.38   6.7%  swap out:        0  disk 4:        4r
0w
uptime:       0:25:45.82         context :   838418

irq  0:    154583 timer                 irq  6:         1
irq  1:         3 keyboard              irq  8:        96 rtc
irq  2:         0 cascade [4]           irq  9:     13516 megaraid
irq  3:         4 serial                irq 11:      3417 eth0, eth1
irq  4:        62 serial                irq 12:         7 PS/2 Mouse
irq  5:         0 usb-ohci              irq 15:       132 aic7xxx, aic7xxx

ver_linux output
Linux server 2.4.22-pre3 #1 SMP Tue Jul 8 12:17:09 PDT 2003 i686 unknown
unknown GNU/Linux

Gnu C                  3.3
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
modutils               2.4.25
e2fsprogs              1.33
PPP                    2.4.1
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.4
Procps                 3.1.9
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0
Modules Loaded         dazuko ipt_TCPMSS ipt_TOS ipt_string ipt_psd
ipt_pkttype ipt_unclean ipt_state ipt_REJECT ipt_LOG ipt_limit
iptable_mangle iptable_nat iptable_filter ip_tables ip_conntrack_h323
ip_conntrack_mms ip_conntrack_irc ip_conntrack_ftp ip_conntrack tulip rtc
usb-ohci usbcore aic7xxx megaraid sd_mod scsi_mod

