Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264265AbUHNRXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbUHNRXo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 13:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264278AbUHNRXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 13:23:44 -0400
Received: from colino.net ([82.228.82.76]:45048 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S264265AbUHNRXk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 13:23:40 -0400
Date: Sat, 14 Aug 2004 19:22:11 +0200
From: Colin Leroy <colin@colino.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.8: IDE cdrecord problems
Message-ID: <20040814192211.312de2a2@jack.colino.net>
X-Mailer: Sylpheed-Claws 0.9.12cvs59.1 (GTK+ 2.4.4; powerpc-unknown-linux-gnu)
X-Face: Fy:*XpRna1/tz}cJ@O'0^:qYs:8b[Rg`*8,+o^[fI?<%5LeB,Xz8ZJK[r7V0hBs8G)*&C+XA0qHoR=LoTohe@7X5K$A-@cN6n~~J/]+{[)E4h'lK$13WQf$.R+Pi;E09tk&{t|;~dakRD%CLHrk6m!?gA,5|Sb=fJ=>[9#n1Bu8?VngkVM4{'^'V_qgdA.8yn3)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Sat__14_Aug_2004_19_22_11_+0200_1/I7K_bwULcJObxq"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Sat__14_Aug_2004_19_22_11_+0200_1/I7K_bwULcJObxq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

I upgraded today from 2.6.8-rc2 to 2.6.8. Tried to burn a CD, using
cdrecord on /dev/hdc, which is an IDE CD burner (Matshita something in
the iBook G4).

Something quickly took all the memory and swap available, OOM started to
kill things and the laptop got bogged down so much that I had to reboot.
Everything is fine with 2.6.8-rc2
Excerpts of the syslog are attached. I started to burn at about 14:52,
tried to login remotely at 15:27:47 (but ssh timed out).


-- 
Colin
  Like any talented dog, it can do flips. 
  Like any talented cow, it can do precision bitmap alignment.  

--Multipart=_Sat__14_Aug_2004_19_22_11_+0200_1/I7K_bwULcJObxq
Content-Type: text/plain;
 name="syslog.txt"
Content-Disposition: attachment;
 filename="syslog.txt"
Content-Transfer-Encoding: 7bit

Aug 14 14:54:08 [kernel] hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
Aug 14 14:54:08 [kernel] cdrom: This disc doesn't have any tracks I recognize!
Aug 14 14:54:08 [kernel] hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
Aug 14 15:02:56 [kernel] oom-killer: gfp_mask=0xd2
Aug 14 15:03:15 [kernel] DMA per-cpu:
Aug 14 15:27:47 [sshd] Did not receive identification string from 192.168.0.3
Aug 14 15:38:17 [kernel] cpu 0 cold: low 0, high 32, batch 16
Aug 14 15:38:21 [kernel] Normal per-cpu: empty
Aug 14 15:38:55 [kernel] oom-killer: gfp_mask=0x1d2
Aug 14 15:39:30 [kernel] DMA per-cpu:
Aug 14 15:41:13 [kernel] oom-killer: gfp_mask=0x1d2
                - Last output repeated 2 times -
Aug 14 15:42:56 [kernel] DMA per-cpu:
Aug 14 15:43:34 [kernel] oom-killer: gfp_mask=0x1d2
Aug 14 15:44:49 [kernel] adt746x: Stopping CPU fan.
Aug 14 15:45:54 [kernel] oom-killer: gfp_mask=0x1d2
Aug 14 15:48:57 [kernel] oom-killer: gfp_mask=0x1d2
                - Last output repeated 2 times -
Aug 14 15:51:31 [kernel] DMA per-cpu:
Aug 14 15:52:57 [kernel] DMA: 38*4kB 5*8kB 0*16kB 1*32kB 0*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 1760kB
Aug 14 15:53:00 [kernel] Normal: empty
Aug 14 15:53:26 [kernel] oom-killer: gfp_mask=0x1d2
Aug 14 15:56:28 [kernel] DMA per-cpu:
Aug 14 15:57:17 [kernel] HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
Aug 14 15:58:41 [kernel] Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB
Aug 14 15:58:44 [kernel] protections[]: 0 0 0
Aug 14 15:59:36 [kernel] Active:124 inactive:5770 dirty:0 writeback:5283 unstable:0 free:414 slab:2098 mapped:758 pagetables:470
Aug 14 16:03:05 [kernel] DMA: 14*4kB 25*8kB 15*16kB 11*32kB 1*64kB 0*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 1680kB
Aug 14 16:04:19 [kernel] Normal: empty
Aug 14 16:11:01 [kernel] cpu 0 cold: low 0, high 32, batch 16
Aug 14 16:18:45 [kernel] protections[]: 404 404 404
Aug 14 16:20:45 [kernel] protections[]: 404 404 404
Aug 14 16:22:05 [kernel] Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB
Aug 14 16:23:48 [kernel] Active:152 inactive:5621 dirty:0 writeback:5543 unstable:0 free:654 slab:2077 mapped:198 pagetables:360
Aug 14 16:24:41 [kernel] DMA free:1648kB min:808kB low:1616kB high:2424kB active:968kB inactive:23972kB present:655360kB
Aug 14 16:26:05 [kernel] protections[]: 404 404 404
Aug 14 16:30:40 [kernel] oom-killer: gfp_mask=0x1d2
Aug 14 16:36:20 [kernel] DMA per-cpu:
Aug 14 16:37:54 [kernel] Active:105 inactive:6157 dirty:0 writeback:5828 unstable:0 free:392 slab:2063 mapped:419 pagetables:311
Aug 14 16:40:08 [kernel] DMA free:1568kB min:808kB low:1616kB high:2424kB active:420kB inactive:24628kB present:655360kB
Aug 14 16:43:20 [kernel] protections[]: 0 0 0
Aug 14 16:46:34 [kernel] HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
Aug 14 16:49:41 [kernel] protections[]: 0 0 0
Aug 14 16:51:04 [kernel] DMA: 18*4kB 10*8kB 22*16kB 11*32kB 1*64kB 0*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 1688kB

--Multipart=_Sat__14_Aug_2004_19_22_11_+0200_1/I7K_bwULcJObxq--
