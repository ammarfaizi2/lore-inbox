Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288019AbSBVQXO>; Fri, 22 Feb 2002 11:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288896AbSBVQXE>; Fri, 22 Feb 2002 11:23:04 -0500
Received: from linux.kappa.ro ([194.102.255.131]:53212 "EHLO linux.kappa.ro")
	by vger.kernel.org with ESMTP id <S288019AbSBVQWz>;
	Fri, 22 Feb 2002 11:22:55 -0500
Date: Fri, 22 Feb 2002 18:24:33 +0200 (EET)
From: Teodor Iacob <theo@astral.kappa.ro>
X-X-Sender: <theo@linux.kappa.ro>
Reply-To: <Teodor.Iacob@astral.kappa.ro>
To: <linux-kernel@vger.kernel.org>
Subject: Problem? 802.1q kernel 2.4.18-rc1-rmap12f
Message-ID: <Pine.LNX.4.31.0202221815590.28962-100000@linux.kappa.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-RAVMilter-Version: 8.3.0(snapshot 20011220) (linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I shall describe the hardware involved and the layout first:
A PC router i815 Motherboard, 3 Intel Etherexpress PRO 100 82557
Allied Telesyn AT-8224XL 802.1q capable.

Software: Slackware 8.0, kernel 2.4.18-rc1-rmap12f.

I want to use the eth0 as 2 subinterfaces with 802.1q with vlan IDs 3 and
5, so this is how I set the whole thing up:

/sbin/ifconfig eth0 up # This to make the link of the interface up
vconfig add eth0 5
vconfig add eth0 3

/sbin/ifconfig eth0.5 inet ..etc..
/sbin/ifconfig eth0.3 inet ...etc..

and I have also the default gateway through the eth0.5 vlan.

Now after a fresh start, I can ping whatever I want, but I cannot start a
file transfer, it just locks up after first 1024 bytes ( as seen with tick
in simple ftp command ).

If I change the startup scripts and ofc the aty switch to not use tagging
on the interface and use simple eth0 the transfer is ok. Now I get the
vlan back and the transfer works, but if I restore the configurations and
reboot the machine I cannot make transfers. I was able to ping -s 1400
stations through this 802.1q, but I didn't test further up (1467
or more ..etc.).

Does anybody can help me track this thing? Could this be kernel related?


Respectfully,
Teodor Iacob



