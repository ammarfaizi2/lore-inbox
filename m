Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265207AbTLZShM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 13:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265209AbTLZShM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 13:37:12 -0500
Received: from viefep14-int.chello.at ([213.46.255.13]:21563 "EHLO
	viefep14-int.chello.at") by vger.kernel.org with ESMTP
	id S265207AbTLZShK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 13:37:10 -0500
Date: Fri, 26 Dec 2003 19:37:10 +0100
From: Andreas Theofilu <abfall@TheosSoft.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0: Bug in AIC7xxx driver
Message-Id: <20031226193710.68d80774.abfall@TheosSoft.net>
Organization: Theos Soft
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi to all,

I'm not subscribed to this list, so please CC me your answer.

I use kernel 2.6.0 (stable). The problem is with the older driver for
AIC7xxx devices. I've compiled the driver into the kernel and when it
boots, it does not detect the hard drive connected to the SCSI-bus.

I'm using an Adaptec 2940W that worked fine with all kernels up to 2.4.x.
There is also a CD-RW drive, DDS2 tape and DDS3 tape connected. This
devices are detected and I can use them as usual.

This are the boot messages:
<6>(scsi0) <Adaptec AHA-294X SCSI host adapter> found at PCI 0/8/0
<6>(scsi0) Narrow Channel, SCSI ID=7, 16/255 SCBs
<6>(scsi0) Downloading sequencer code... 415 instructions downloaded
<6>scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.6/5.2.0
<4>       <Adaptec AHA-294X SCSI host adapter>
<5>  Vendor: YAMAHA    Model: CRW8424S          Rev: 1.0f
<5>  Type:   CD-ROM                             ANSI SCSI revision: 02
<5>  Vendor: HP        Model: C1533A            Rev: 9608
<5>  Type:   Sequential-Access                  ANSI SCSI revision: 02
<5>  Vendor: SONY      Model: SDT-9000          Rev: 0400
<5>  Type:   Sequential-Access                  ANSI SCSI revision: 02
<4>ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as device
<6>scsi1 : SCSI host adapter emulation for IDE ATAPI devices
<5>  Vendor: LG        Model: DVD-ROM DRD8160B  Rev: 1.01
<5>  Type:   CD-ROM                             ANSI SCSI revision: 02
<6>st: Version 20030811, fixed bufsize 32768, s/g segs 256
<4>Attached scsi tape st0 at scsi0, channel 0, id 4, lun 0
<4>st0: try direct i/o: yes, max page reachable by HBA 1048575
<4>Attached scsi tape st1 at scsi0, channel 0, id 5, lun 0
<4>st1: try direct i/o: yes, max page reachable by HBA 1048575
<6>(scsi0:0:3:0) Synchronous at 10.0 Mbyte/sec, offset 15.
<4>sr0: scsi3-mmc drive: 24x/16x writer cd/rw xa/form2 cdda tray
<6>Uniform CD-ROM driver Revision: 3.12
<7>Attached scsi CD-ROM sr0 at scsi0, channel 0, id 3, lun 0
<4>sr1: scsi3-mmc drive: 0x/48x cd/rw xa/form2 cdda tray
<7>Attached scsi CD-ROM sr1 at scsi1, channel 0, id 0, lun 0
<5>Attached scsi generic sg0 at scsi0, channel 0, id 3, lun 0,  type 5
<5>Attached scsi generic sg1 at scsi0, channel 0, id 4, lun 0,  type 1
<5>Attached scsi generic sg2 at scsi0, channel 0, id 5, lun 0,  type 1
<5>Attached scsi generic sg3 at scsi1, channel 0, id 0, lun 0,  type 5

Above the hard drive connected at ID1 does not show up as it did
with older kernels.

I tried to compile the kernel with the newer version of AIC7xxx, but got
compile time errors, because it is missing the symbol "dbopen". I assume
that I've not updated something I should have. But I don't know what.

Does anybody know of that bug and does there exist a patch already?

-- 
Andreas Theofilu
http://www.TheosSoft.net/

                     --==| Enjoy the science of Linux! |==--
