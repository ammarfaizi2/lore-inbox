Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283591AbRLDX0Q>; Tue, 4 Dec 2001 18:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283590AbRLDX0H>; Tue, 4 Dec 2001 18:26:07 -0500
Received: from web20305.mail.yahoo.com ([216.136.226.86]:19218 "HELO
	web20305.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S283581AbRLDXZu>; Tue, 4 Dec 2001 18:25:50 -0500
Message-ID: <20011204232549.96879.qmail@web20305.mail.yahoo.com>
Date: Tue, 4 Dec 2001 15:25:49 -0800 (PST)
From: Q A <qarce_mail_lists@yahoo.com>
Subject: ARP shows client is given wrong MAC Address for system with 2 NICs
To: linux-kernel@vger.kernel.org
Cc: qarce@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am not on the linux-kernel mailing list so please
reply all.

My problem:

Note that in the following description _(A) refers to
the interface that was brought on line first in the
system after boot up.   That is if eth0 came up first,
_(A) refers to eth0.   If eth1 came up first, _(A)
refers to eth1.  Read on and you will see the problem.


I have a system with 2 NICs in one box.  When I telent
to IP(A) and I am allowed to connect with no problems
and are given MAC(A) which I check with the arp
command.  I then telnet to IP(B) and are given MAC(A).
 Yes, MAC(A).  I then ifdown NIC(B) device and telent
to IP(B) and connect with no problems.

Now looking at ARP I see I am connected to NIC(A)
because I have the MAC(A) according to ARP.  I then
bring up NIC(B) and shutdown NIC(A) while still
connected as it looks to NIC(A).  I look at ARP and I
see I still have the MAC(A). I press enter in the
telnet window connected to what I ARP tells me is
NIC(A) and everything works.   I check ARP and see
that the I now have MAC(B) for the connection.

I really need to fix this soon so that I can bring
this box online.

The system:
uname -a...
Linux system-name 2.4.9-13SGI_XFS_PR1enterprise #1 SMP
Fri Nov 2 23:44:39 CST 2001 i686 unknown

lsmod...
Module                  Size  Used by
nfs                    94706   0  (autoclean)
lockd                  60515   0  (autoclean) [nfs]
sunrpc                 84519   0  (autoclean) [nfs
lockd]
autofs                 13596   6  (autoclean)
e1000                  47194   0  (autoclean)
eepro100               19799   1  (autoclean)
lvm-mod                64482  16 
usb-ohci               23358   0  (unused)
usbcore                66308   1  [usb-ohci]
raid1                  16069   4 
raid0                   4314   1 
cciss                  21124   4 
aic7xxx               119883   8 
sd_mod                 12859   8 
scsi_mod              110515   2  [aic7xxx sd_mod]

This is eth1: e1000                  
This is eth0: eepro100               


Based on RH Linux 7.1 and as you can see SGI XFS.



I found two notes on this subject on the net.

Both are from this list.   
One has the subject:  RE: ARP out the wrong interface
>From Date:  Feb, 09 2001

This one notes that 2.2.18 and 2.4 have a patch to
allow you to:

# sysctl -w net.ipv4.conf.all.arpfilter=1

Yet I only found net.ipv4.conf.all.arp_filter
setting this to 1(on) has no effect on the problem.

The second one has subject:  RE: [2.2] Network
Interface aliasing
>From Date:  Nov, 9 1999

This on talks about IP in the 2.2 kernel.  It talks
about an "optimization to reduce work on hosts
monitoring in promiscuous mode."  "The decision is
made on IP level and by IP address, MAC level details
are inessential."  So I gather what I am seeing is to
optimise network trafic.  But I think there is a bug.


I am not a kernel programmer.  Please have a look and
let me know what more info you need.

Thanks,

Q 

__________________________________________________
Do You Yahoo!?
Buy the perfect holiday gifts at Yahoo! Shopping.
http://shopping.yahoo.com
