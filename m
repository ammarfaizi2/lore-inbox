Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266186AbRF3Opm>; Sat, 30 Jun 2001 10:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266188AbRF3Opc>; Sat, 30 Jun 2001 10:45:32 -0400
Received: from mail.fmtc.com ([137.118.131.7]:16851 "EHLO
	ponyexpress.neonova.net") by vger.kernel.org with ESMTP
	id <S266186AbRF3Op3>; Sat, 30 Jun 2001 10:45:29 -0400
Message-ID: <3B3D0B4A.9040603@fmtc.com>
Date: Fri, 29 Jun 2001 17:12:10 -0600
From: Joshua Schmidklofer <menion@fmtc.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:0.9.1+) Gecko/20010623
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.5 - IpConfig, BOOTP not functioning.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel developers,
   I hate to burden you with menial quetions, but:   How does ipconfig 
get called & initialized?   I am new to attempting to _read_ kernel 
source, and not nearly a good C progammer.   This is killing me, But 
after two hours of looking,I can't figure out how ipconfig get 
initialized & called.   I am using 2.4.5, I enabled ipconfig debug <via 
the define>, because i am trying to see why my floppy-only NFS 
workstation is not functioning, and I am getting no where.   There are 
no debug messages.   10 different kernel compiles, 2 with save 
.config-mrproper-reconfig cycles.  I am stumped, and i don't know what 
to do.


I am trying to boot a system w/an epic100 card in it using BOOTP.  I 
have a 10 meg network, dumb hub, and 5 clients.   10.0.0.3 is running 
Redhat's bootparamd.   2 entries in /etc/bootparams.   Both look fine.   
Running a syslog monitor in one term, and a tcpdump in another.  Niether
report any BOOTP, ARP, RARP, or DHCP traffic.
Floppy client boots, says something very similar to this.
.
.<snip>
<epic100 initialization>
eth0: SCSC EPIC/100 83c170 at 0x6100 IRQ 10.....
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: Route cache hash table of 512 buckets
TCP: Hash tables configures (established 4096 bind 4096(
NET4: Unix Domain Sockets 1.0/SMP for Linux NET4.
Root-NFS: No NFS Server Availibl, giving up
VFS:  Unable to mount root, trying floppy
<snip>

I do have CONFIG_IP_PNP_BOOTP set, and I can verify from the System.map 
that ipconfig is being compiled, and linked.  However, there is no 
evidence that it initializes, and certainly no debug messages.  From the 
look of it, the system has moved passed init'ing the network.   I have 
no idea what to do next.


thanks,
 Joshua



