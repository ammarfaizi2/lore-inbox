Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318016AbSHQRIq>; Sat, 17 Aug 2002 13:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318018AbSHQRIq>; Sat, 17 Aug 2002 13:08:46 -0400
Received: from atlas015.atlas-iap.es ([194.224.1.15]:33995 "EHLO
	antoli.gallimedina.net") by vger.kernel.org with ESMTP
	id <S318016AbSHQRIp>; Sat, 17 Aug 2002 13:08:45 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Subject: Re: BUG: 2.4.19 and Promise 20267 doesn't recognise ide raid
Date: Sat, 17 Aug 2002 19:12:01 +0200
X-Mailer: KMail [version 1.3.2]
References: <E17flxe-0007iH-00@antoli.gallimedina.net> <20020817133132.C23498@bitwizard.nl>
In-Reply-To: <20020817133132.C23498@bitwizard.nl>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17g77J-00087z-00@antoli.gallimedina.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 17 August 2002 13:31, Rogier Wolff wrote:
> On Fri, Aug 16, 2002 at 08:36:38PM +0200, Ricardo Galli wrote:
> > Just upgraded a server from 2.4.17 to 2.4.19, had to go down to 2.4.18.
> >
> > It doesn't boot with 2.4.19, the error is (ish, messages are not logged
> > because the disk cannot be mounted, neither the root filesystem):
>
> What disks do you have?
> 			Roger.

Sorry...

Disks:

# dmesg
hde: ST320410A, ATA DISK drive
hdg: ST320410A, ATA DISK drive
...
Drive 0 is 19092 Mb (33 / 0)
Drive 1 is 19092 Mb (34 / 0)
Raid1 array consists of 2 drives.
Promise Fasttrak(tm) Softwareraid driver for linux version 0.03beta
Highpoint HPT370 Softwareraid driver for linux version 0.01
No raid array found
^^^^^^^^^^^^^^^^^^^
...
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
...
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ataraid(114,5), internal journal
EXT3-fs: mounted filesystem with writeback data mode.





# df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/ataraid/d0p2      4805760   1971804   2589836  44% /
/dev/ataraid/d0p1        13863      5391      7756  42% /boot
/dev/ataraid/d0p5     13931584   1874316  11349584  15% /home





Promise:
# lspci -v
00:0c.0 RAID bus controller: Promise Technology, Inc. 20267 (rev 02)
        Subsystem: Promise Technology, Inc.: Unknown device 4d39
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at b000 [size=8]
        I/O ports at b400 [size=4]
        I/O ports at b800 [size=8]
        I/O ports at bc00 [size=4]
        I/O ports at c000 [size=64]
        Memory at f8100000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [58] Power Management version 1

-- 
  ricardo
       A paperless office has about as much a chance as a paperless bathroom
