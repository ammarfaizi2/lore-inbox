Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264530AbUFPTDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264530AbUFPTDM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 15:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264582AbUFPTDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 15:03:11 -0400
Received: from crianza.bmb.uga.edu ([128.192.34.109]:10369 "EHLO crianza")
	by vger.kernel.org with ESMTP id S264530AbUFPTBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 15:01:13 -0400
Date: Wed, 16 Jun 2004 15:00:56 -0400
To: Alasdair G Kergon <agk@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: processes hung in D (raid5/dm/ext3)
Message-ID: <20040616190056.GA14580@porto.bmb.uga.edu>
Reply-To: foo@porto.bmb.uga.edu
References: <20040615062236.GA12818@porto.bmb.uga.edu> <20040615030932.3ff1be80.akpm@osdl.org> <20040615150036.GB12818@porto.bmb.uga.edu> <20040615162607.5805a97e.akpm@osdl.org> <20040616021633.GB13672@porto.bmb.uga.edu> <20040616125754.GF6627@agk.surrey.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040616125754.GF6627@agk.surrey.redhat.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: foo@porto.bmb.uga.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2004 at 01:57:54PM +0100, Alasdair G Kergon wrote:
> On Tue, Jun 15, 2004 at 10:16:33PM -0400, foo@porto.bmb.uga.edu wrote:
> > # pvdisplay /dev/md0
> > # vgdisplay vg0
> > # lvdisplay 
> 
> LVM2/device-mapper diagnostics
> ==============================
> 
> If you use the 'lvs' reporting tool, we'll get fuller information more 
> concisely, so we can check for any anomalies. 
> [Unlikely to be any based on what you've posted so far, but worth
> eliminating the possibility.]
> 
> Run:
>   vgs -v
>   lvs -v
>   pvs -v

# vgs -v
    Finding all volume groups
    Finding volume group "vg0"
VG   Attr Ext   #PV #LV #SN VSize   VFree   VG UUID                               
vg0  wz-- 4.00M   1  36   0 546.92G 244.92G EameBy-n1m#-cwNa-rKqz-YqoM-hSEH-BKVeQQ

# lvs -v
    Finding all logical volumes
LV       VG   #Seg Attr   LSize  Maj Min Origin Snap%  Move Move%  LV UUID                               
barolo12 vg0     1 -wn-ao 10.00G  -1  -1                           YZc9tO-y5wz-ssWJ-WSbI-spgV-Mc9y-6FLTne
barolo34 vg0     1 -wn-ao 10.00G  -1  -1                           pLm#IR-fDFS-7VPZ-oiI5-Y#Ry-Myat-CE3Pki
barolo5  vg0     1 -wn-ao  5.00G  -1  -1                           sRjOxq-s71y-mR0e-4Upn-b2Ai-#Og0-MFIEnK
barolo6  vg0     1 -wn-ao  5.00G  -1  -1                           zqQC0B-3fOk-EBIQ-acmD-iuoK-WJ75-gnUBZN
barolo7  vg0     1 -wn-ao  5.00G  -1  -1                           XO587u-M123-CLUb-SFsu-67c0-w37#-zoiHv4
barolo8  vg0     1 -wn-ao  5.00G  -1  -1                           r!EeKN-QMqm-7E3m-0ie#-WHXX-cH5V-1R5dY5
baroloA  vg0     1 -wn-ao  5.00G  -1  -1                           Ew7Tqi-CC4h-IPao-7wVC-Haac-H!PU-916oNP
baroloB  vg0     1 -wn-ao  5.00G  -1  -1                           Gx6Maq-8Noj-xkQH-Lmhc-t4!B-KEYk-e6QstK
baroloC  vg0     1 -wn-ao  5.00G  -1  -1                           kJs2L5-sbfS-MGr0-3GE9-i#gw-#EqV-2nyYB5
baroloD  vg0     1 -wn-ao  5.00G  -1  -1                           miH6a7-o3oE-Jus3-fBpu-Uk9y-HSj2-QR8mZJ
home     vg0     1 -wn-ao 25.00G  -1  -1                           yQFLXG-KLog-TdWQ-Rvis-35U1-jUj1-zO0h3M
mail     vg0     1 -wn-ao  1.00G  -1  -1                           3wldn3-gsCE-3s7u-ezf4-5bcj-vPGv-CKJkX!
merlot1  vg0     1 -wn-ao  5.00G  -1  -1                           MPrl1Z-CC2!-fOO7-qfzg-waGj-DsL9-bq1CZx
merlot2  vg0     1 -wn-ao  5.00G  -1  -1                           qWVGBV-xMEj-TWEW-RbQU-ANd3-CaR8-huHrwY
merlot3  vg0     1 -wn-ao  5.00G  -1  -1                           1YzfGJ-YMOq-oZFQ-0zWc-3dDY-uYPj-gJeOr!
merlot4  vg0     1 -wn-ao  5.00G  -1  -1                           DSchwn-x0ym-Q8Ru-zPQE-cPJs-MWxU-b#f0IT
merlot5  vg0     1 -wn-ao  5.00G  -1  -1                           H4k3kV-2rQC-!4It-FxcM-hC4E-!w1N-uU9EsY
merlot6  vg0     1 -wn-ao  5.00G  -1  -1                           y#YLZw-njzQ-6N2U-hzxK-LgzX-FHyX-Us51Cv
merlot7  vg0     1 -wn-ao  5.00G  -1  -1                           W3rBLv-6#MS-lDXO-l6FW-#r!4-iO7S-lSF!Oa
merlot8  vg0     1 -wn-ao  5.00G  -1  -1                           zQ86Hm-qu!I-J4XQ-!saa-lTZd-Yn8G-Q#!VRd
muscat1  vg0     1 -wn-ao 10.00G  -1  -1                           kDzHiI-NqU9-gJXY-JPNA-eBEK-H8dr-ZLTrkE
muscat2  vg0     1 -wn-ao 10.00G  -1  -1                           Ldv#Hl-ux9c-rKdS-bSw3-dS8I-HlMY-w3bYxr
muscat3  vg0     1 -wn-ao 10.00G  -1  -1                           4kPUY9-3aoD-rIB1-Fg5O-Ivh0-QL68-CvQYF5
muscat4  vg0     1 -wn-ao 10.00G  -1  -1                           OHMsUY-Or4N-9lK8-GXQ3-UBbN-1x60-3484SZ
muscat5  vg0     1 -wn-ao 10.00G  -1  -1                           jdOxGO-PCOg-IYxm-!U1D-n#p5-wygg-N1ZbuK
muscat6  vg0     1 -wn-ao 10.00G  -1  -1                           X!PH6U-q6jy-lqcX-e!x3-TgSr-cCyt-RhXdwM
muscat7  vg0     1 -wn-ao 10.00G  -1  -1                           i2JjoV-N85X-tGn4-YH0!-2433-iAg2-kqFBuJ
muscat8  vg0     1 -wn-ao 10.00G  -1  -1                           KiaWjv-CouY-rgtV-Xnqe-YWQP-#Odc-#eLOV3
software vg0     1 -wn-ao 20.00G  -1  -1                           jOWXFS-#QlU-el#j-vqtJ-dm6b-ntL0-aXoEHg
vbah     vg0     1 -wn-ao 30.00G  -1  -1                           SG3vYW-OT26-SZhL-66f1-FrDl-Ml5N-YUfAe4
vcaa     vg0     1 -wn-ao  5.00G  -1  -1                           b4B540-c!K!-kJUe-bGk9-slM6-qSOf-bqh1jB
vidb     vg0     1 -wn-ao  1.00G  -1  -1                           Gf3dyd-1j#i-f2rf-LIzp-eZdr-jnrR-oyahVN
xarello1 vg0     1 -wn-ao 10.00G  -1  -1                           GbVm!D-OzE5-2Ecs-G4Mz-HPL5-7E31-fU5kBP
xarello2 vg0     1 -wn-ao 10.00G  -1  -1                           pPrVSQ-lyRz-t7Ml-hG4k-cFvg-jtMm-p0#Ot0
xarello3 vg0     1 -wn-ao 10.00G  -1  -1                           gsvzH3-SmcT-jp2q-RdHt-nO81-gquH-zqdaLH
xarello4 vg0     1 -wn-ao 10.00G  -1  -1                           dQLM2u-SdsS-VENi-rTA0-EM9T-KhHt-m39gwf

# pvs -v
    Scanning for physical volume names
PV         VG   Fmt  Attr PSize   PFree   PV UUID                               
/dev/md0   vg0  lvm2 a-   546.92G 244.92G a76cj4-Fvnf-xkY8-bE0j-Wcdk-jtb0-mq9NbF


> Can you confirm that you're not running *any* LVM or device-mapper
> commands during your backup sequence?

I'm using the same backup script that I was using before without LVM,
there are no snapshots or anything.  It's just Amanda with a simple
script to run it.

> Confirm the versions by running:
>   lvm version

# lvm version
  LVM version:     2.00.06 (2003-08-20)
  Library version: 1.00.05-ioctl-cvs (2003-09-01)
  Driver version:  4.1.0

>   dmsetup targets

The dmsetup I have installed doesn't have this command.

> 
> And dump the static device-mapper state, by running:
>   dmsetup -v table
>   dmsetup status

# dmsetup -v table /dev/mapper/vg0-home 
Name:              vg0-home
State:             ACTIVE
Tables present:    LIVE
Open count:        1
Event number:      0
Major, minor:      253, 0
Number of targets: 1
UUID: EameByn1m#cwNarKqzYqoMhSEHBKVeQQyQFLXGKLogTdWQRvis35U1jUj1zO0h3M

# dmsetup -v status /dev/mapper/vg0-home
Name:              vg0-home
State:             ACTIVE
Tables present:    LIVE
Open count:        1
Event number:      0
Major, minor:      253, 0
Number of targets: 1
UUID: EameByn1m#cwNarKqzYqoMhSEHBKVeQQyQFLXGKLogTdWQRvis35U1jUj1zO0h3M

0 52428800 linear 

> 
> [I'll get that fixed to provide a column-based output too.]
> 
> And finally mount sysfs and run
>   ls -ld .../block/dm-*

# ls -ld /sys/block/dm-*
drwxr-xr-x    2 root     root            0 Jun 16 03:11 /sys/block/dm-0/
drwxr-xr-x    2 root     root            0 Jun 16 03:11 /sys/block/dm-1/
drwxr-xr-x    2 root     root            0 Jun 16 03:11 /sys/block/dm-10/
drwxr-xr-x    2 root     root            0 Jun 16 03:11 /sys/block/dm-11/
drwxr-xr-x    2 root     root            0 Jun 16 03:11 /sys/block/dm-12/
drwxr-xr-x    2 root     root            0 Jun 16 03:11 /sys/block/dm-13/
drwxr-xr-x    2 root     root            0 Jun 16 03:11 /sys/block/dm-14/
drwxr-xr-x    2 root     root            0 Jun 16 03:11 /sys/block/dm-15/
drwxr-xr-x    2 root     root            0 Jun 16 03:11 /sys/block/dm-16/
drwxr-xr-x    2 root     root            0 Jun 16 03:11 /sys/block/dm-17/
drwxr-xr-x    2 root     root            0 Jun 16 03:11 /sys/block/dm-18/
drwxr-xr-x    2 root     root            0 Jun 16 03:11 /sys/block/dm-19/
drwxr-xr-x    2 root     root            0 Jun 16 03:11 /sys/block/dm-2/
drwxr-xr-x    2 root     root            0 Jun 16 03:11 /sys/block/dm-20/
drwxr-xr-x    2 root     root            0 Jun 16 03:11 /sys/block/dm-21/
drwxr-xr-x    2 root     root            0 Jun 16 03:11 /sys/block/dm-22/
drwxr-xr-x    2 root     root            0 Jun 16 03:11 /sys/block/dm-23/
drwxr-xr-x    2 root     root            0 Jun 16 03:11 /sys/block/dm-24/
drwxr-xr-x    2 root     root            0 Jun 16 03:11 /sys/block/dm-25/
drwxr-xr-x    2 root     root            0 Jun 16 03:11 /sys/block/dm-26/
drwxr-xr-x    2 root     root            0 Jun 16 03:11 /sys/block/dm-27/
drwxr-xr-x    2 root     root            0 Jun 16 03:11 /sys/block/dm-28/
drwxr-xr-x    2 root     root            0 Jun 16 03:11 /sys/block/dm-29/
drwxr-xr-x    2 root     root            0 Jun 16 03:11 /sys/block/dm-3/
drwxr-xr-x    2 root     root            0 Jun 16 03:11 /sys/block/dm-30/
drwxr-xr-x    2 root     root            0 Jun 16 03:11 /sys/block/dm-31/
drwxr-xr-x    2 root     root            0 Jun 16 03:11 /sys/block/dm-32/
drwxr-xr-x    2 root     root            0 Jun 16 03:11 /sys/block/dm-33/
drwxr-xr-x    2 root     root            0 Jun 16 03:11 /sys/block/dm-34/
drwxr-xr-x    2 root     root            0 Jun 16 03:11 /sys/block/dm-35/
drwxr-xr-x    2 root     root            0 Jun 16 03:11 /sys/block/dm-4/
drwxr-xr-x    2 root     root            0 Jun 16 03:11 /sys/block/dm-5/
drwxr-xr-x    2 root     root            0 Jun 16 03:11 /sys/block/dm-6/
drwxr-xr-x    2 root     root            0 Jun 16 03:11 /sys/block/dm-7/
drwxr-xr-x    2 root     root            0 Jun 16 03:11 /sys/block/dm-8/
drwxr-xr-x    2 root     root            0 Jun 16 03:11 /sys/block/dm-9/

-ryan
