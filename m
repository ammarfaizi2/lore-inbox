Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131472AbRDJLXZ>; Tue, 10 Apr 2001 07:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131477AbRDJLXQ>; Tue, 10 Apr 2001 07:23:16 -0400
Received: from dl-adsl-sao-C8B6CF1E.sao.terra.com.br ([200.182.207.30]:23049
	"EHLO baco.haus") by vger.kernel.org with ESMTP id <S131472AbRDJLXJ>;
	Tue, 10 Apr 2001 07:23:09 -0400
Date: Tue, 10 Apr 2001 08:22:50 -0300
From: Christoph Simon <datageo@terra.com.br>
To: linux-kernel@vger.kernel.org
Subject: Problems with Adaptec in 2.4.3
Message-Id: <20010410082250.0c207f75.datageo@terra.com.br>
X-Mailer: Sylpheed version 0.4.62 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a machine running a 2.4.2 kernel with an Adaptec SCSI
board. This worked well, but when I ran into a hang with the 2.4.2
loop device, testing a CD image, I decided to switch to 2.4.3.  But
then I get strange error messages during boot, and the machine reacts
(kind of once a day) in a very strange way, like programs failing
which never fail. Might those errors have lead to a subtile kind of
file system corruption? Inspite of the `request_module' message below,
I compiled the driver into the kernel and do not use any disk related
kernel modules. And of course, at a so early stage, the root file
system was not yet mounted.

Below are the SCSI related lines from the boot messages, first with
2.4.3, and 3 minutes later back with the previous 2.4.2
kernel. Andybody how could tell me what to do? Please CC me as I'm not
on this list. Thanks in advance.

---------------------------------------------------------------------------

Linux version 2.4.3
SCSI subsystem driver Revision: 1.00
request_module[scsi_hostadapter]: Root fs not mounted
request_module[scsi_hostadapter]: Root fs not mounted
request_module[scsi_hostadapter]: Root fs not mounted
PCI: Found IRQ 11 for device 00:0f.0
The same IRQ used for device 00:11.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.5
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Wide Channel A, SCSI Id=7, 32/255 SCBs

scsi0:0:0:0: Attempting to queue an ABORT message
scsi0:0:0:0: Device is active, asserting ATN
Recovery code sleeping
Recovery code awake
Timer Expired
aic7xxx_abort returns 8195
scsi0:0:0:0: Attempting to queue a TARGET RESET message
aic7xxx_dev_reset returns 8195
Recovery SCB completes
scsi: device set offline - not ready or command retry failed after bus reset: host 0 channel 0 id 0 lun 0
  Vendor: QUANTUM   Model: ATLAS_V_18_WLS    Rev: 0230
  Type:   Direct-Access                      ANSI SCSI revision: 03
Detected scsi disk sda at scsi0, channel 0, id 2, lun 0
(scsi0:A:2): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
  Vendor: HP        Model: CD-Writer+ 9200   Rev: 1.0e
  Type:   CD-ROM                             ANSI SCSI revision: 04
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 6, lun 0
(scsi0:A:6): 10.000MB/s transfers (10.000MHz, offset 15)
scsi0:0:2:0: Tagged Queuing enabled.  Depth 8
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
SCSI device sda: 35861388 512-byte hdwr sectors (18361 MB)
 /dev/scsi/host0/bus0/target2/lun0: p1 p2 p3

---------------------------------------------------------------------------

Linux version 2.4.2
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 11 for device 00:0f.0
PCI: The same IRQ used for device 00:11.0
(scsi0) <Adaptec AIC-7892 Ultra 160/m SCSI host adapter> found at PCI 0/15/0
(scsi0) Wide Channel, SCSI ID=7, 32/255 SCBs
(scsi0) Downloading sequencer code... 392 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
       <Adaptec AIC-7892 Ultra 160/m SCSI host adapter>
(scsi0:0:2:0) Synchronous at 80.0 Mbyte/sec, offset 63.
  Vendor: QUANTUM   Model: ATLAS_V_18_WLS    Rev: 0230
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:0:6:0) Synchronous at 10.0 Mbyte/sec, offset 15.
  Vendor: HP        Model: CD-Writer+ 9200   Rev: 1.0e
  Type:   CD-ROM                             ANSI SCSI revision: 04
Detected scsi disk sda at scsi0, channel 0, id 2, lun 0
SCSI device sda: 35861388 512-byte hdwr sectors (18361 MB)
 /dev/scsi/host0/bus0/target2/lun0: p1 p2 p3
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 6, lun 0
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray


--
Christoph Simon
datageo@terra.com.br
---
^X^C
q
quit
:q
^C
end
x
exit
ZZ
^D
?
help
shit
.
