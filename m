Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129208AbQKVOtM>; Wed, 22 Nov 2000 09:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130063AbQKVOtD>; Wed, 22 Nov 2000 09:49:03 -0500
Received: from front4.grolier.fr ([194.158.96.54]:58337 "EHLO
        front4.grolier.fr") by vger.kernel.org with ESMTP
        id <S129208AbQKVOs4>; Wed, 22 Nov 2000 09:48:56 -0500
To: linux-kernel@vger.kernel.org
Subject: [2.4.0-test11 BUG] kernel: _isofs_bmap: block >= EOF (559939584, 4096)
Reply-to: cbroult@yahoo.com
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Wed_Nov_22_14:37:25_2000-1"
Content-Transfer-Encoding: 7bit
From: Christophe Broult <cbroult@yahoo.com>
Date: 22 Nov 2000 14:37:25 +0100
Message-ID: <87em04ku0a.fsf@valiosys.com>
User-Agent: T-gnus/6.14.5 (based on Gnus v5.8.7) (revision 06) EMY/1.13.9
 (Art is long, life is short) Chao/1.14.1 (Rokujizò)
 APEL/10.2 Emacs/20.7 (i386-debian-linux-gnu) MULE/4.0 (HANANOEN)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Multipart_Wed_Nov_22_14:37:25_2000-1
Content-Type: text/plain; charset=US-ASCII


With 2.4.0-test11, I am unable to access to the content of CDROMs. For example:

  root@madison:~# mount /cdrom/ ; df ;ls -la /cdrom ; umount /cdrom/
  Filesystem           1k-blocks      Used Available Use% Mounted on
  /dev/scsi/host0/bus0/target0/lun0/part2
                         1014990    893570     68975  93% /
  /dev/scsi/host0/bus0/target0/lun0/part1
                          508647    363802    118571  76% /usr/share
  /dev/scsi/host0/bus0/target0/lun0/part4
                          494423    437471     31415  94% /home
  /dev/scsi/host0/bus0/target3/lun0/cd
                          658882    658882         0 100% /cdrom
  total 0
  root@madison:~# 

and the following lines show up in a xconsole window:

  Nov 22 14:08:30 localhost kernel: VFS: Disk change detected on device sr(11,0)
  Nov 22 14:08:30 localhost kernel: ISO 9660 Extensions: Microsoft Joliet Level 1
  Nov 22 14:08:31 localhost kernel: ISO 9660 Extensions: RRIP_1991A
  Nov 22 14:08:31 localhost kernel: _isofs_bmap: block >= EOF (559939584, 4096)

I have just verified that this problem did not occur with
2.4.0-test10. 

Chris

-- 
"Man is distinguished from all other creatures by
the faculty of laughter."
- Joseph Addison

--Multipart_Wed_Nov_22_14:37:25_2000-1
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline; filename="ver.txt"

-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux madison 2.4.0-test11 #1 Mon Nov 20 12:46:56 CET 2000 i586 unknown
Kernel modules         2.3.20
Gnu C                  2.95.2
Gnu Make               3.79.1
Binutils               2.10.91
Linux C Library        > libc.2.2
Dynamic linker         ldd (GNU libc) 2.2
Procps                 2.0.6
Mount                  2.10o
Net-tools              2.05
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         ipv6 af_packet ipt_state ipt_REJECT ipt_LOG ipt_limit parport_pc lp ip_conntrack_ftp parport iptable_nat ip_conntrack iptable_filter ip_tables gus ad1848 sound soundcore quickcam videodev usb-ohci usbcore binfmt_misc

--Multipart_Wed_Nov_22_14:37:25_2000-1--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
