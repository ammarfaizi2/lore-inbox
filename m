Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbQLPJoq>; Sat, 16 Dec 2000 04:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129485AbQLPJog>; Sat, 16 Dec 2000 04:44:36 -0500
Received: from SPYLOG-TCNET.tcnet.ru ([195.230.65.66]:40198 "HELO gate.local")
	by vger.kernel.org with SMTP id <S129345AbQLPJo1>;
	Sat, 16 Dec 2000 04:44:27 -0500
From: "Max Shaposhnikov" <shapa@spylog.ru>
To: <linux-kernel@vger.kernel.org>
Subject: softraid5 bug on ALL 2.4 kernels
Date: Fri, 15 Dec 2000 23:48:24 +0300
Message-ID: <AOEJJKJLFPBGFHPGKHAFCEJDCBAA.shapa@spylog.ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4test10 - mke2fs work fine, but dd if=/dev/zero of=/mnt/testfile
count=2000000 gor kernel error
2.4test11 - mke2fs result kernel error immideatly.
2.4test12 - mke2fs result kernel error immideatly.

kernels- SMP&UP with apic (SCSI drivers don't work good without enabled APIC
on SMP motherboard in UP kernel)

Mother Intel GX
2xPIII-850
1Gb and 2Gb
Adaptec 7860 SCSI (but on IDE soft RAID got the same error)

raid1 work fine.

dmesg:

 disk 25, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
 disk 26, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
md: updating md0 RAID superblock on device
hdd [events: 00000001](write) hdd's sb offset: 45034816
md: syncing RAID array md0
md: minimum _guaranteed_ reconstruction speed: 100 KB/sec/disc.
md: using maximum available idle IO bandwith (but not more than 100000
KB/sec) for reconstruction.
md: using 124k window, over a total of 45034816 blocks.
hdc [events: 00000001](write) hdc's sb offset: 45034816
hda [events: 00000001](write) hda's sb offset: 45034816
.
kernel BUG at buffer.c:765!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012d852>]
EFLAGS: 00010286
eax: 0000001c   ebx: f7f89d08   ecx: c027c508   edx: 00000001
esi: f6f04160   edi: f6f04000   ebp: f7f89cc0   esp: f7001e8c
ds: 0018   es: 0018   ss: 0018
Process raid5d (pid: 284, stackpage=f7001000)
Stack: c022ad45 c022affa 000002fd 00000004 c01d9788 f7f89cc0 00000001
00000004
       f6f04000 00000001 00000000 c01da299 f6f04000 00000001 00000001
f6f04000
       f7003000 f6f04000 00000003 00000003 f7003000 c01dadf2 f6f04000
f6f04000
Call Trace: [<c022ad45>] [<c022affa>] [<c01d9788>] [<c01da299>] [<c01dadf2>]
[<c010a92e>] [<c010a94c>]
       [<c01149b6>] [<c01db326>] [<c01e2046>] [<c0107c34>]
Code: 0f 0b 83 c4 0c 5b c3 8d 76 00 55 57 56 53 8b 74 24 14 8b 54

Max Shaposhnikov,
SpyLog UNIX administrator (www.spylog.ru)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
