Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264706AbUEMTvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264706AbUEMTvw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 15:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264640AbUEMTjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 15:39:12 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:54011 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S264519AbUEMTZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 15:25:31 -0400
From: Bernd Schubert <bernd.schubert@pci.uni-heidelberg.de>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: aic79xx trouble
Date: Thu, 13 May 2004 21:25:21 +0200
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_ou8oAEFz+D+g+Z5";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405132125.28053.bernd.schubert@pci.uni-heidelberg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_ou8oAEFz+D+g+Z5
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

Hello,

we are just in the process of setting up a new server, which will serve the=
=20
data of an IDE/SCSI raid system (transtec 5008). Some partions of this raid=
=20
device are also mirrored via drbd to a failover system. During a full resyn=
c=20
of all (3) failover partitions *from* the failover server, the main-server=
=20
first logs many scsi errors and later the access to the raid-partitions=20
completely locks up.

Below is some relevant dmesg output, I already enabled the verbose option f=
or=20
the aic79xx driver. Should I also enable debugging, if so, which mode?

Any help is highly appreciated.


Thanks in advance,
	Bernd


SCSI subsystem driver Revision: 1.00
ahd_pci:2:6:1: Reading VPD from SEEPROM...ahd_pci:2:6:1: VPD parsing=20
successful
ahd_pci:2:6:1: Reading SEEPROM...done.
ahd_pci:2:6:1: STPWLEVEL is on
ahd_pci:2:6:1: Manual Primary Termination
ahd_pci:2:6:1: Manual Secondary Termination
ahd_pci:2:6:1: Primary High byte termination Enabled
ahd_pci:2:6:1: Primary Low byte termination Enabled
ahd_pci:2:6:1: Secondary High byte termination Disabled
ahd_pci:2:6:1: Secondary Low byte termination Disabled
ahd_pci:2:6:1: Downloading Sequencer Program... 656 instructions downloaded
ahd_pci:2:6:1: Features 0x1c101, Bugs 0x700002, Flags 0x43f0
ahd_pci:2:6:0: Reading VPD from SEEPROM...ahd_pci:2:6:0: VPD parsing=20
successful
ahd_pci:2:6:0: Reading SEEPROM...done.
ahd_pci:2:6:0: STPWLEVEL is on
ahd_pci:2:6:0: Manual Primary Termination
ahd_pci:2:6:0: Manual Secondary Termination
ahd_pci:2:6:0: Primary High byte termination Enabled
ahd_pci:2:6:0: Primary Low byte termination Enabled
ahd_pci:2:6:0: Secondary High byte termination Disabled
ahd_pci:2:6:0: Secondary Low byte termination Disabled
ahd_pci:2:6:0: Downloading Sequencer Program... 656 instructions downloaded
ahd_pci:2:6:0: Features 0x1c101, Bugs 0x700002, Flags 0x43f1
scsi0 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.10
        <Adaptec AIC7902 Ultra320 SCSI adapter>
        aic7902: Ultra320 Wide Channel A, SCSI Id=3D7, PCI-X 67-100Mhz, 512=
 SCBs

scsi1 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.10
        <Adaptec AIC7902 Ultra320 SCSI adapter>
        aic7902: Ultra320 Wide Channel B, SCSI Id=3D7, PCI-X 67-100Mhz, 512=
 SCBs

blk: queue f7961e18, I/O limit 4095Mb (mask 0xffffffff)
scsi0:A:0:0: DV failed to configure device.  Please file a bug report again=
st=20
this driver.
(scsi0:A:0:0): Sending PPR bus_width 1, period 9, offset 7f, ppr_options 2
(scsi0:A:0:0): Received PPR width 1, period 9, offset 1f,options 2
	Filtered to width 1, period 9, offset 1f, options 2
(scsi0:A:0): 6.600MB/s transfers (16bit)
scsi0: target 0 using 16bit transfers
(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, 16bit)
scsi0: target 0 synchronous with period =3D 0x9, offset =3D 0x1f(DT)
  Vendor: transtec  Model:                   Rev: 0001
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue f7961c18, I/O limit 4095Mb (mask 0xffffffff)
(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, 16bit)
scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 4101521408 512-byte hdwr sectors (2099979 MB)
 sda: sda1 sda2 sda3 < sda5 sda6 sda7 sda8 >



drbd: initialised. Version: 0.6.12 (api:64/proto:62)
drbd0: Connection established. size=3D24410736 KB / blksize=3D4096 B
drbd1: Connection established. size=3D19535008 KB / blksize=3D4096 B
drbd1: Synchronisation started blks=3D15
drbd2: Connection established. size=3D195760026 KB / blksize=3D4096 B
drbd2: Synchronisation started blks=3D15
scsi0:0:0:0: Attempting to abort cmd f78fce00: 0x28 0x0 0x5 0xd1 0x2a 0x89 =
0x0=20
0x0 0x78 0x0
scsi0: At time of recovery, card was not paused
>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
scsi0: Dumping Card State at program address 0x25 Mode 0x11
Card was paused
HS_MAILBOX[0x0] INTCTL[0xc0]:(SWTMINTEN|SWTMINTMASK)=20
SEQINTSTAT[0x0] SAVED_MODE[0x11] DFFSTAT[0x33]:(CURRFIFO_NONE|FIFO0FREE|
=46IFO1FREE)=20
SCSISIGI[0x0]:(P_DATAOUT) SCSIPHASE[0x0] SCSIBUS[0x0]=20
LASTPHASE[0x1]:(P_DATAOUT|P_BUSFREE) SCSISEQ0[0x0]=20
SCSISEQ1[0x12]:(ENAUTOATNP|ENRSELI) SEQCTL0[0x0] SEQINTCTL[0x0]=20
SEQ_FLAGS[0xc0]:(NO_CDB_SENT|NOT_IDENTIFIED) SEQ_FLAGS2[0x0]=20
SSTAT0[0x0] SSTAT1[0x8]:(BUSFREE) SSTAT2[0x0] SSTAT3[0x0]=20
PERRDIAG[0x0] SIMODE1[0xa4]:(ENSCSIPERR|ENSCSIRST|ENSELTIMO)=20
LQISTAT0[0x0] LQISTAT1[0x0] LQISTAT2[0x0] LQOSTAT0[0x0]=20
LQOSTAT1[0x0] LQOSTAT2[0x0]=20

SCB Count =3D 32 CMDS_PENDING =3D 2 LASTSCB 0xffff CURRSCB 0x8 NEXTSCB 0x0
qinstart =3D 53192 qinfifonext =3D 53192
QINFIFO:
WAITING_TID_QUEUES:
Pending list:
  5 FIFO_USE[0x0] SCB_CONTROL[0x64]:(DISCONNECTED|TAG_ENB|DISCENB)=20
SCB_SCSIID[0x7]=20
 11 FIFO_USE[0x0] SCB_CONTROL[0x64]:(DISCONNECTED|TAG_ENB|DISCENB)=20
SCB_SCSIID[0x7]=20
Total 2
Kernel Free SCB list: 8 25 23 24 6 13 18 26 20 30 22 9 19 29 17 12 14 28 21=
 3=20
15 27 0 10 2 31 1 16 7 4=20
Sequencer Complete DMA-inprog list:=20
Sequencer Complete list:=20
Sequencer DMA-Up and Complete list:=20

scsi0: FIFO0 Free, LONGJMP =3D=3D 0x80ff, SCB 0x0
SEQIMODE[0x3f]:(ENCFG4TCMD|ENCFG4ICMD|ENCFG4TSTAT|ENCFG4ISTAT|ENCFG4DATA|
ENSAVEPTRS)=20
SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89]:(FIFOEMP|HDONE|PRELOAD_AVAIL)=20
SG_CACHE_SHADOW[0x2]:(LAST_SEG) SG_STATE[0x0] DFFSXFRCTL[0x0]=20
SOFFCNT[0x0] MDFFSTAT[0x5]:(FIFOFREE|DLZERO) SHADDR =3D 0x00, SHCNT =3D 0x0=
=20
HADDR =3D 0x00, HCNT =3D 0x0 CCSGCTL[0x10]:(SG_CACHE_AVAIL)=20
scsi0: FIFO1 Free, LONGJMP =3D=3D 0x81d7, SCB 0x8
SEQIMODE[0x3f]:(ENCFG4TCMD|ENCFG4ICMD|ENCFG4TSTAT|ENCFG4ISTAT|ENCFG4DATA|
ENSAVEPTRS)=20
SEQINTSRC[0x0] DFCNTRL[0x4]:(DIRECTION) DFSTATUS[0x89]:(FIFOEMP|HDONE|
PRELOAD_AVAIL)=20
SG_CACHE_SHADOW[0x2]:(LAST_SEG) SG_STATE[0x0] DFFSXFRCTL[0x0]=20
SOFFCNT[0x0] MDFFSTAT[0x5]:(FIFOFREE|DLZERO) SHADDR =3D 0x00, SHCNT =3D 0x0=
=20
HADDR =3D 0x00, HCNT =3D 0x0 CCSGCTL[0x10]:(SG_CACHE_AVAIL)=20
LQIN: 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0=
x0=20
0x0 0x0=20
scsi0: LQISTATE =3D 0x0, LQOSTATE =3D 0x0, OPTIONMODE =3D 0x52
scsi0: OS_SPACE_CNT =3D 0x20 MAXCMDCNT =3D 0x0

SIMODE0[0xc]:(ENOVERRUN|ENIOERR)=20
CCSCBCTL[0x0]=20
scsi0: REG0 =3D=3D 0x10, SINDEX =3D 0x1e0, DINDEX =3D 0xe1
scsi0: SCBPTR =3D=3D 0x8, SCB_NEXT =3D=3D 0xff00, SCB_NEXT2 =3D=3D 0xff97
CDB 2a 0 1 80 1 7a
STACK: 0x13 0x0 0x0 0x0 0x0 0x0 0x0 0x0
<<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
DevQ(0:0:0): 0 waiting
(scsi0:A:0:0): Device is disconnected, re-queuing SCB
Recovery code sleeping
(scsi0:A:0:0): Abort Tag Message Sent
(scsi0:A:0:0): SCB 11 - Abort Completed.
Recovery SCB completes
found =3D=3D 0x1
Recovery code awake
scsi0:0:0:0: Attempting to abort cmd f78fd000: 0x28 0x0 0x3 0x7c 0x71 0x99 =
0x0=20
0x0 0x78 0x0
scsi0:0:0:0: Command not found
scsi0:A:0: no active SCB for reconnecting target - issuing BUS DEVICE RESET
SAVED_SCSIID =3D=3D 0x7, SAVED_LUN =3D=3D 0x0, REG0 =3D=3D 0xff00 ACCUM =3D=
 0x0
SEQ_FLAGS =3D=3D 0xc0, SCBPTR =3D=3D 0xb, BTT =3D=3D 0xff00, SINDEX =3D=3D =
0x104
SELID =3D=3D 0x0, SCB_SCSIID =3D=3D 0x7, SCB_LUN =3D=3D 0x0, SCB_CONTROL =
=3D=3D 0x68
SCSIBUS[0] =3D=3D 0xb, SCSISIGI =3D=3D 0xe6
SXFRCTL0 =3D=3D 0x88
SEQCTL0 =3D=3D 0x0
>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
scsi0: Dumping Card State at program address 0x14a Mode 0x33
Card was paused
HS_MAILBOX[0x0] INTCTL[0xc0]:(SWTMINTEN|SWTMINTMASK)=20
SEQINTSTAT[0x0] SAVED_MODE[0x11] DFFSTAT[0x33]:(CURRFIFO_NONE|FIFO0FREE|
=46IFO1FREE)=20
SCSISIGI[0xe6]:(P_MESGIN|REQI|BSYI) SCSIPHASE[0x8]:(MSG_IN_PHASE)=20
SCSIBUS[0xb] LASTPHASE[0xe0]:(P_MESGIN) SCSISEQ0[0x0]=20
SCSISEQ1[0x12]:(ENAUTOATNP|ENRSELI) SEQCTL0[0x0] SEQINTCTL[0x0]=20
SEQ_FLAGS[0xc0]:(NO_CDB_SENT|NOT_IDENTIFIED) SEQ_FLAGS2[0x0]=20
SSTAT0[0x2]:(SPIORDY) SSTAT1[0x9]:(REQINIT|BUSFREE)=20
SSTAT2[0x0] SSTAT3[0x0] PERRDIAG[0x0] SIMODE1[0xac]:(ENSCSIPERR|ENBUSFREE|
ENSCSIRST|ENSELTIMO)=20
LQISTAT0[0x0] LQISTAT1[0x0] LQISTAT2[0x0] LQOSTAT0[0x0]=20
LQOSTAT1[0x0] LQOSTAT2[0x0]=20

SCB Count =3D 32 CMDS_PENDING =3D 0 LASTSCB 0xffff CURRSCB 0xb NEXTSCB 0x0
qinstart =3D 53195 qinfifonext =3D 53195
QINFIFO:
WAITING_TID_QUEUES:
Pending list:
Total 0
Kernel Free SCB list: 11 5 8 25 23 24 6 13 18 26 20 30 22 9 19 29 17 12 14 =
28=20
21 3 15 27 0 10 2 31 1 16 7 4=20
Sequencer Complete DMA-inprog list:=20
Sequencer Complete list:=20
Sequencer DMA-Up and Complete list:=20

scsi0: FIFO0 Free, LONGJMP =3D=3D 0x80ff, SCB 0x0
SEQIMODE[0x3f]:(ENCFG4TCMD|ENCFG4ICMD|ENCFG4TSTAT|ENCFG4ISTAT|ENCFG4DATA|
ENSAVEPTRS)=20
SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89]:(FIFOEMP|HDONE|PRELOAD_AVAIL)=20
SG_CACHE_SHADOW[0x2]:(LAST_SEG) SG_STATE[0x0] DFFSXFRCTL[0x0]=20
SOFFCNT[0x0] MDFFSTAT[0x5]:(FIFOFREE|DLZERO) SHADDR =3D 0x00, SHCNT =3D 0x0=
=20
HADDR =3D 0x00, HCNT =3D 0x0 CCSGCTL[0x10]:(SG_CACHE_AVAIL)=20
scsi0: FIFO1 Free, LONGJMP =3D=3D 0x81d7, SCB 0xb
SEQIMODE[0x3f]:(ENCFG4TCMD|ENCFG4ICMD|ENCFG4TSTAT|ENCFG4ISTAT|ENCFG4DATA|
ENSAVEPTRS)=20
SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89]:(FIFOEMP|HDONE|PRELOAD_AVAIL)=20
SG_CACHE_SHADOW[0x2]:(LAST_SEG) SG_STATE[0x0] DFFSXFRCTL[0x0]=20
SOFFCNT[0x0] MDFFSTAT[0x5]:(FIFOFREE|DLZERO) SHADDR =3D 0x00, SHCNT =3D 0x0=
=20
HADDR =3D 0x00, HCNT =3D 0x0 CCSGCTL[0x10]:(SG_CACHE_AVAIL)=20
LQIN: 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0=
x0=20
0x0 0x0=20
scsi0: LQISTATE =3D 0x0, LQOSTATE =3D 0x0, OPTIONMODE =3D 0x52
scsi0: OS_SPACE_CNT =3D 0x20 MAXCMDCNT =3D 0x0

SIMODE0[0xc]:(ENOVERRUN|ENIOERR)=20
CCSCBCTL[0x0]=20
scsi0: REG0 =3D=3D 0xff00, SINDEX =3D 0x104, DINDEX =3D 0xa9
scsi0: SCBPTR =3D=3D 0xb, SCB_NEXT =3D=3D 0xff00, SCB_NEXT2 =3D=3D 0xff97
CDB 28 0 5 80 a9 53
STACK: 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0
<<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
DevQ(0:0:0): 0 waiting
scsi0:A:0:0: Target did not send an IDENTIFY message. LASTPHASE =3D 0x60.
(scsi0:A:0): 80.000MB/s transfers (80.000MHz DT)
scsi0: target 0 using 8bit transfers
(scsi0:A:0): 3.300MB/s transfers
scsi0: target 0 using asynchronous transfers
scsi0: target 1 using 8bit transfers
scsi0: target 1 using asynchronous transfers
scsi0: target 2 using 8bit transfers
scsi0: target 2 using asynchronous transfers
scsi0: target 3 using 8bit transfers
scsi0: target 3 using asynchronous transfers
scsi0: target 4 using 8bit transfers
scsi0: target 4 using asynchronous transfers
scsi0: target 5 using 8bit transfers
scsi0: target 5 using asynchronous transfers
scsi0: target 6 using 8bit transfers
scsi0: target 6 using asynchronous transfers
scsi0: target 8 using 8bit transfers
scsi0: target 8 using asynchronous transfers
scsi0: target 9 using 8bit transfers
scsi0: target 9 using asynchronous transfers
scsi0: target 10 using 8bit transfers
scsi0: target 10 using asynchronous transfers
scsi0: target 11 using 8bit transfers
scsi0: target 11 using asynchronous transfers
scsi0: target 12 using 8bit transfers
scsi0: target 12 using asynchronous transfers
scsi0: target 13 using 8bit transfers
scsi0: target 13 using asynchronous transfers
scsi0: target 14 using 8bit transfers
scsi0: target 14 using asynchronous transfers
scsi0: target 15 using 8bit transfers
scsi0: target 15 using asynchronous transfers
scsi0: Issued Channel A Bus Reset. 0 SCBs aborted
scsi0: target 0 using 8bit transfers
scsi0: target 0 using asynchronous transfers
scsi0: SCSI bus reset delivered. 0 SCBs aborted.
scsi0:A:0:0: DV failed to configure device.  Please file a bug report again=
st=20
this driver.
(scsi0:A:0:0): Sending PPR bus_width 1, period 9, offset 7f, ppr_options 2
(scsi0:A:0:0): Received PPR width 1, period 9, offset 1f,options 2
	Filtered to width 1, period 9, offset 1f, options 2
(scsi0:A:0): 6.600MB/s transfers (16bit)
scsi0: target 0 using 16bit transfers
(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, 16bit)
scsi0: target 0 synchronous with period =3D 0x9, offset =3D 0x1f(DT)




=2D-=20
Bernd Schubert
Physikalisch Chemisches Institut / Theoretische Chemie
Universit=E4t Heidelberg
INF 229
69120 Heidelberg
e-mail: bernd.schubert@pci.uni-heidelberg.de

--Boundary-02=_ou8oAEFz+D+g+Z5
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAo8unLR5WR6DFumYRAqFjAJ972xaATu9RYU9QCksSx9W/UwGu2ACeOQaA
aMdIteZrk0OSznbCqQzUFT8=
=M8H9
-----END PGP SIGNATURE-----

--Boundary-02=_ou8oAEFz+D+g+Z5--
