Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265815AbTA2MZP>; Wed, 29 Jan 2003 07:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265816AbTA2MZP>; Wed, 29 Jan 2003 07:25:15 -0500
Received: from relay.muni.cz ([147.251.4.35]:14735 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S265815AbTA2MZO>;
	Wed, 29 Jan 2003 07:25:14 -0500
Date: Wed, 29 Jan 2003 13:34:34 +0100
From: Jan Kasprzak <kas@informatics.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20 NFS server lock-up (SMP)
Message-ID: <20030129133434.A1584@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello, world!\n

	I have a problem on Linux 2.4.20 with NFS server - my NFS
server from time to time (currently about once a day) stops responding
to NFS requests. Apart from that the system is OK, I can log in via SSH,
and I can run "/sbin/reboot -n -f" to reboot it. Also filesystem operations
seem to be OK, even Samba server is responding. When this happens,
I see all nfsd processes and lockd process to be stuck in the "D" state.

	The server is dual athlon with large (700GB) LVM volume
on six IDE drives, RedHat 8.0, 2.4.20 (also tried 2.4.21-pre1 and pre3),
ext3fs. It serves about 2000 subdirs in this volume (= export list
has ~2000 lines) to about 100 NFS clients (various Linuxes, IRIX 6.5,
Solaris 2.7 and 2.8), and runs Samba for ~50 Windows clients.
It has 1GB of RAM (CONFIG_HIGHMEM=y, but no CONFIG_HIGHIO).

	Does anybody have similar problem on a big NFS server?
The server with those kernel was stable with ~20 NFS clients
and 150 exported subdirs on the same volume, so I think this
problem is some race condition triggered only by bigger load.
However, the server still has load average <1, so it is not
overloaded.

	Another question connected to this: How can I do
an equivalent of AltGr+ScrollLock remotely? I want to get
a call trace of the nfsd processes, but it is difficult for me
to go to the machine physically.

	Thanks,

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
|-- If you start doing things because you hate others and want to screw  --|
|-- them over the end result is bad.   --Linus Torvalds to the BBC News  --|
