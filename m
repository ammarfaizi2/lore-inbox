Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVDMXgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVDMXgk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 19:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVDMXgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 19:36:40 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:19539 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261226AbVDMXgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 19:36:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=r9uPBq8YTAsBGaQk9FuSgYT/lkgzdXxg4AmhlZuJIIUK1oi68b4WwhZWpgJg0vWKvmr2yWLC/6fbZwPcCQXXtX+56q/DMpvGvT+GBsDlnomYqy0HrJKPAb+W73ApZdN3hKweM9RfuQGukShR+7hEM8cVVxOs6Jbq9yRo1+aGtd0=
Date: Thu, 14 Apr 2005 01:36:19 +0200
From: Bradley Reed <bradreed1@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: CDR read problems with 2.6.11?
Message-ID: <20050414013619.342cea4e@galactus.localdomain>
X-Mailer: Sylpheed-Claws 1.9.6 (GTK+ 2.6.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running 2.6.11 with -ac4 and
realtime-preempt-2.6.11-final-V0.7.40-00 patches. Up to now, no
complaints, great job everyone.

Today I burnt two data backup CDs onto CD-R (I used k3b if it
matters) and the burn went 100% fine. No errors, I can read the
disks on other computers or on this one if I reboot into a different
kernel (2.4.28 for instance). Unfortunately I cannot read them from
the kernel I burned them with. [1]

mount yields:

root@galactus:~[1009]# mount /mnt/cdrom
mount: wrong fs type, bad option, bad superblock on /dev/cdrom,
       missing codepage or other error
       In some cases useful info is found in syslog - try
       dmesg | tail  or so
       
dmesg shows:

hda: irq timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hda: DMA disabled
hda: ATAPI reset complete
hda: irq timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hda: ATAPI reset complete
hda: tray open
end_request: I/O error, dev hda, sector 64
isofs_fill_super: bread failed, dev=hda, iso_blknum=16, block=16
hda: irq timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hda: ATAPI reset complete

Obviously the tray is NOT open, but the other errors don't mean much
to me.

The drive is a NEC DVD+RW ND-5100A

Any suggestions on why I can't read (or burn correctly) the disks with 2.6.11?

Brad

[1] Actually although they mount and I can ls them under 2.4.28, not all the
files seem to be complete. The last few tarballs seem to be incomplete.
Earlier ones in the ls listing seem fine. Strange.
