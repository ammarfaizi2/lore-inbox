Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266431AbSLKGAJ>; Wed, 11 Dec 2002 01:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266560AbSLKGAJ>; Wed, 11 Dec 2002 01:00:09 -0500
Received: from eagle.energo.debryansk.ru ([213.24.142.129]:19381 "EHLO
	jocker.energo.debryansk.ru") by vger.kernel.org with ESMTP
	id <S266431AbSLKGAD> convert rfc822-to-8bit; Wed, 11 Dec 2002 01:00:03 -0500
From: Alexander Grishin <gri@ses.bryansk.elektra.ru>
Organization: SES
To: linux-kernel@vger.kernel.org
Subject: Oops 2.4.20-ac1 & 2.4.21-pre1 ide-scsi
Date: Wed, 11 Dec 2002 09:07:58 +0300
User-Agent: KMail/1.4.6
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200212110907.58987.gri@ses.bryansk.elektra.ru>
X-OriginalArrivalTime: 11 Dec 2002 06:04:51.0390 (UTC) FILETIME=[37C785E0:01C2A0DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The next commands:

  modprobe ide-scsi
  rmmod ide-scsi
  mount -t iso9660 /dev/hdc /mnt

 Oops....

Dec 11 08:58:28 gri kernel: scsi0 : SCSI host adapter emulation for IDE ATAPI 
devices
Dec 11 08:58:28 gri kernel:   Vendor: _NEC      Model: NR-7900A          Rev: 
1.23
Dec 11 08:58:28 gri kernel:   Type:   CD-ROM                             ANSI 
SCSI revision: 02
Dec 11 08:58:37 gri kernel: scsi : 0 hosts left.
Dec 11 08:58:37 gri kernel: idescsi_cleanup: hdc: failed to unregister! 
Dec 11 08:58:37 gri kernel: hdc: usage 0, busy 0, driver d8932700, Dbusy 1
Dec 11 08:58:37 gri kernel: hdc: exit_idescsi_module() called while still busy
Dec 11 08:58:55 gri kernel: Unable to handle kernel paging request at virtual 
address 24448b61
Dec 11 08:58:55 gri kernel:  printing eip:
Dec 11 08:58:55 gri kernel: 24448b61
Dec 11 08:58:55 gri kernel: *pde = 00000000
Dec 11 08:58:55 gri kernel: Oops: 0000
Dec 11 08:58:55 gri kernel: CPU:    0
Dec 11 08:58:55 gri kernel: EIP:    0010:[<24448b61>]    Not tainted
Dec 11 08:58:55 gri kernel: EFLAGS: 00010246
Dec 11 08:58:55 gri kernel: eax: d674be3c   ebx: c02be13c   ecx: c02c02ec   
edx: d8932700
Dec 11 08:58:55 gri kernel: esi: c14461c0   edi: d654c3c0   ebp: 00001600   
esp: d674bd80
Dec 11 08:58:55 gri kernel: ds: 0018   es: 0018   ss: 0018
Dec 11 08:58:55 gri kernel: Process mount (pid: 379, stackpage=d674b000)
Dec 11 08:58:55 gri kernel: Stack: c01acfcd d654c3c0 d674be3c c02be13c 
c14461c0 c14461c0 c14461dc c013ce24 
Dec 11 08:58:55 gri kernel:        d654c3c0 d674be3c 00000000 c14461c0 
fffffff3 d674be38 00000003 c013cec7 
Dec 11 08:58:55 gri kernel:        c14461c0 d654c3c0 d674be3c 00000000 
00000000 d654c3c0 00000000 00000000 
Dec 11 08:58:55 gri kernel: Call Trace:    [<c01acfcd>] [<c013ce24>] 
[<c013cec7>] [<c013c996>] [<c013b959>]
Dec 11 08:58:55 gri kernel:   [<c014cc5e>] [<d8934944>] [<c013bd5c>] 
[<d8934944>] [<c014ddc3>] [<c014e0c5>]
Dec 11 08:58:55 gri kernel:   [<c014df19>] [<c014e4f1>] [<c010733f>]
Dec 11 08:58:55 gri kernel: 
Dec 11 08:58:55 gri kernel: Code:  Bad EIP value.


