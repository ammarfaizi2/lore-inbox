Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266094AbSKLCLY>; Mon, 11 Nov 2002 21:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266095AbSKLCLY>; Mon, 11 Nov 2002 21:11:24 -0500
Received: from sccrmhc01.attbi.com ([204.127.202.61]:44477 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S266094AbSKLCLX>; Mon, 11 Nov 2002 21:11:23 -0500
From: "Buddy Lumpkin" <b.lumpkin@attbi.com>
To: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: path_to_inst like functionality for Linux needed
Date: Mon, 11 Nov 2002 18:22:07 -0800
Message-ID: <000d01c289f2$4cd4ca60$0472e50c@peecee>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that linux is riddled with cool features, wouldn't it be nice to
start adding the small touches that seperate the rock solid UNIX OS's
that scale on very large, complex systems from the small systems that
only rival windows NT? In this case, im talking about functionality that
works along the lines of the path_to_inst file in Solaris. (hopefully I
have set the hook, read on)

For those that don't know how path_to_inst works, I'll explain it here:

/etc/path_to_inst is used to preserve device ordering. When Solaris is
booted with -r (reconfigure) it takes the device tree (on sparc systems,
devices are arranged in a tree structure) and for each leaf (device) it
checks the path_to_inst file to see if a device instance already exists
for it. If not, it assigns one and creates the corresponding device file
and adds an entry to path_to_inst.

This protects against the following scenario:

Say you have five slots. PCI, SBUS, whatever. And lets say you put a
network card in slot 1. Then let's say a year later you add another of
the exact same model to slot 0. Now eth0 (or whatever) in linux is
actually the other card!!

I know this doesn't seem like a big deal to the hackers of the world,
but to an experienced system administrator this is a HUGE missing. Let
me give an example.

Solaris has two common Volume Managers. Veritas Volume Manager and
Solstice Disksuite.

For the most part, Disksuite will do just about anything that Volume
Manager will do, but people continue to pay $2,000 - $10,000 for Volume
Manager. Why? Because of the little things .

When Volume Manager starts, it looks at a section of all disks on the
system for something called the "Private Region". This section of disk
space is reserved for information that uniquely defines that particular
disks function in life, whether that's as the fourth disk in a RAID 0
stripe, or the third in a concated volume.

Disk Suite will support several types of RAID, etc.. as well, but if you
move the cards or cables around things get really gummed up.

These kinds of things don't matter much to young technical types that
want to remember everything and are submersed in the details (people
like myself actually) but I can tell ya, the big shops are totally
driven by these types of details.

I currently work at a fortune 500 company and I can attest that
standards are based on such trivial items.

So I ask . are there any intentions on adding path_to_inst like
functionality to linux at some point in the future?

 

BTW: Please understand that I love Linux, and im not saying it's not
Enterprise material. Im just identifying a "missing feature" that I
think would be trivial for the right people to add to Linux, and would
go a long way toward making Linux seen as even more of an Enterprise
Ready Operating system.

 

Regards,

 

--Buddy

