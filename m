Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267926AbRGRVFN>; Wed, 18 Jul 2001 17:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267927AbRGRVEx>; Wed, 18 Jul 2001 17:04:53 -0400
Received: from gw-websolut.itnet.pt ([212.54.140.241]:6141 "EHLO
	mail.websolut.net") by vger.kernel.org with ESMTP
	id <S267926AbRGRVEn>; Wed, 18 Jul 2001 17:04:43 -0400
Message-ID: <XFMail.20010718220437.daniel@websolut.net>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <995484908.1279.0.camel@stantz.corp.sgi.com>
Date: Wed, 18 Jul 2001 22:04:37 +0100 (WEST)
From: daniel@websolut.net
To: Florin Andrei <florin@sgi.com>
Subject: RE: noapic strikes back
Cc: linux-kernel@vger.kernel.org, dledford@redhat.com, seawolf-list@redhat.com,
        linux-xfs@oss.sgi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there!

I too have that problem on Intel ISP2150 servers (L440GX+ motherboard is the
problem, of course) and I've seen even quite amazing things - there are boot
disks that work (you don't see the message complaining about shared IRQ 11,
whatever) but the kernel that is put on disk from the installation rpm is not
coherent with the one made for the disk (apic'ed or not apic'ed), so I actually
could install from the first redhat 7.1 xfs iso (xfs 1.0) and get that problem
only upon the first boot from disk - systems hangs forever.

With the problem of fitting a kernel image (with xfs and softraid gets too big)
onto a disk, I could only solve this, compiling my own and putting it on a
network tftp server and booting with PXE (intel servers -> intel NIC -> Fancy
Network Boot); I suppose emulating a 2.88 disk and making a bootable CD would
also do (if you have a CD-ROM).

Cheers,

Daniel Fonseca

On 18-Jul-2001 Florin Andrei wrote:
> I have a SGI 1200 (L440GX+ motherboard, dual PIII) and i'm trying to
> install at least one version of Red Hat 7.1 on it.
> The problem is, while booting up the installer, when it comes to loading
> up the SCSI driver (AIC7xxx) the system is frozen.
> 
> I tried the following boot disks:
> - stock Red Hat 7.1
> - Doug Ledford's updates from people.redhat.com
> - SGI XFS 1.0.1
> 
> I tried to boot the installer with and without "noapic" option.
> 
> I tried to enable and disable the APIC option in BIOS ("PCI IRQs to
> IO-APIC Mapping").
> 
> I tried all the combinations of these. No luck. :-(
> 
> Please, is there anything to do about this problem? I *have* to install
> something newer than RH7.0 on that system.
> 
> Guys, i will try whatever boot disks you will send to me. I'm willing to
> be you guinea pig. :-) Just let's kill the APIC problem for good!
> 
> -- 
> Florin Andrei

-- 
----------------------------------
E-Mail: daniel@websolut.net
Date: 18-Jul-2001
Time: 21:25:56

This message was sent by XFMail
----------------------------------
