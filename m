Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263447AbTLUQC6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 11:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263472AbTLUQC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 11:02:58 -0500
Received: from smtp3.poczta.onet.pl ([213.180.130.29]:9347 "EHLO
	smtp3.poczta.onet.pl") by vger.kernel.org with ESMTP
	id S263447AbTLUQC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 11:02:57 -0500
Date: Sun, 21 Dec 2003 16:28:50 +0100
From: PeteVine <davine@poczta.onet.pl>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0 and auto geometry resizing?
Message-Id: <20031221162850.5b0bbad9@Athlon.net>
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux_from_Scratch/Slackware
My_sister_uses: Slackware
Registered_linux_user: #250250
LFS_ID: 7325
Gadu-Gadu: 209197
X-Face: C{:wp+nxS]S7t~jR~MkF.b<aqAa&f&7MGU?F;B!@V^o3Bc\G?G-,e@a+\Q@{8ua$UB,3dXW
 `CDFVLs|`|>4|!+A`_@_!t;K1/Rdg;Nv5\=$fbOr}pUxpr[V8H'fqI*I>ln0AJ#(\aZ]vT*4,;w=Q?
 -PJ2_-l5]f%Ya1S1xVAnM/AjqNy!qw/=M!:4guk%.}Mpzt<Aap:)@oK/m'G!_)5c!j3]wgBufff[,x
 Fg:JjZPUlco#E&"GKR+oi{nVmTc;g*cZ8P^a
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got this problem with 2.6 kernels, namely I can't use my RAID 
partitions as they are not detected at boot.  I've tracked the issue
to what I believe is auto geometry resizing.

With 2.6 cfdisk shows:

hdc1           Boot, NC       Primary     OnTrackDM6                  33814,13                                   
					Pri/Log     Free Space     		     26205,75


Whereas with 2.4 there's no resizing: 

hdc1                    Primary   Linux swap                        254,99     
hdc5                    Logical   Linux raid autodetect      	98,71    
hdc6                    Logical   Linux raid autodetect		254,99    
hdc7                    Logical   Linux raid autodetect             2599,19    
hdc8                    Logical   Linux raid autodetect            56812,01

The disk in question used to be jumpered to 32 GB 
a few years ago, then treated with ontrack to get the full
capacity. Later the jumper was removed and the disk was
partitioned in Linux 2.4 as shown above. Now, 2.6 even with
auto geometry resizing not compiled in, insists on 
resizing the disk. Any ideas how to get around the problem?

