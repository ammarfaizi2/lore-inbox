Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130132AbQKUXQ5>; Tue, 21 Nov 2000 18:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131010AbQKUXQr>; Tue, 21 Nov 2000 18:16:47 -0500
Received: from edtn006530.hs.telusplanet.net ([161.184.137.180]:48907 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S130132AbQKUXQf>; Tue, 21 Nov 2000 18:16:35 -0500
Date: Tue, 21 Nov 2000 15:46:31 -0700
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org, axp-list@redhat.com
Subject: Re: ux164 (ruffian) fixes
Message-ID: <20001121154631.A27195@mail.harddata.com>
In-Reply-To: <20001121184609.A2889@jurassic.park.msu.ru> <20001121104720.A11074@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.5us
In-Reply-To: <20001121104720.A11074@twiddle.net>; from Richard Henderson on Tue, Nov 21, 2000 at 10:47:20AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2000 at 10:47:20AM -0800, Richard Henderson wrote:
> On Tue, Nov 21, 2000 at 06:46:09PM +0300, Ivan Kokshaysky wrote:
> >    Interesting, other pyxis machines do not seem to be so sensitive,
> >    so I guess some design problems with ux164 motherboard - all this
> >    looks pretty much like timing issues.
> 
> Wow.  Thanks for following through on this.

I can now confirm that I can boot using SCSI disks (the fact that
this was possible for a while into IDE was a life-saver here :-)
a Ruffian (pyxis) Alpha using 2.4.0-test11 kernel and two patches
posted by Ivan (bridges-2.4.0t11.gz and extra ruffian fixes).

Here are fragments from 'dmesg':

....
Booting on Ruffian using machine vector Ruffian from MILO
Command line: bootdevice=sda2 bootfile=/vml240o11.gz root=/dev/sda2
....
SCSI subsystem driver Revision: 1.00
sym53c8xx: at PCI bus 1, device 13, function 0
sym53c8xx: 53c875 detected 
sym53c875-0: rev 0x3 on pci bus 1 device 13 function 0 irq 20
sym53c875-0: ID 7, Fast-20, Parity Checking
sym53c875-0: on-chip RAM at 0xa101000
sym53c875-0: restart (scsi reset).
sym53c875-0: Downloading SCSI SCRIPTS.
scsi0 : sym53c8xx - version 1.6b
  Vendor: IBM       Model: DDRS-39130D       Rev: DC1B
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: TOSHIBA   Model: CD-ROM XM-6201TA  Rev: 1037
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: IBM       Model: DDRS-34560D       Rev: DC1B
  Type:   Direct-Access                      ANSI SCSI revision: 02
sym53c875-0-<2,0>: tagged command queue depth set to 8
sym53c875-0-<10,0>: tagged command queue depth set to 8
Detected scsi disk sda at scsi0, channel 0, id 2, lun 0
Detected scsi disk sdb at scsi0, channel 0, id 10, lun 0
....
VFS: Mounted root (ext2 filesystem) readonly.

Those who posted "me too" could you please test that this is not
only a fluke on my particular machine?

Thanks a bunch, Ivan. Also thanks are extended to Gerard Roudier who
provided a crucial hint in the moment when we appeared to be completly
stuck. :-)

  Michal

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
