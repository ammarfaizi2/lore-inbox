Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131503AbRDCKEz>; Tue, 3 Apr 2001 06:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131020AbRDCKEq>; Tue, 3 Apr 2001 06:04:46 -0400
Received: from 8.ylenurme.ee ([193.40.6.8]:45317 "EHLO ns.linking.ee")
	by vger.kernel.org with ESMTP id <S130317AbRDCKEj>;
	Tue, 3 Apr 2001 06:04:39 -0400
Date: Tue, 3 Apr 2001 12:03:46 +0200 (GMT-2)
From: Elmer Joandi <elmer@linking.ee>
To: linux-kernel@vger.kernel.org
Subject: 2.4.3 SMP: nfs stale handle, fb dualhead hardlock, G400/450 misnaming
Message-ID: <Pine.LNX.4.21.0104031152270.21867-100000@ns.linking.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. stale NFS file handle
	2.4.2-ac28 serving nfs3 from reiserfs
	2.4.3 being nfs3 client,
	nfs damn slow on 100Mbps p2p link.
	mounted nfs  with rsize=8192,wsize=8192
	nfs fast.
	soon got :
		bash-2.04$ls
		ls .: stale NFS file handle
	just about home directory it says so.

2. Hard lockup:
	G450, I set con2fb, switch consoles some times and there it comes.
	swithc between X and single console is OK.

3. seems that I have G450 and linux shows it as G400. 
	bash-2.04$ /sbin/lspci:
	01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 82)	
	/proc/pci:
	 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 130).
	/sbin/lspci -n
	01:00.0 Class 0300: 102b:0525 (rev 82)
	
	at least when I finally, after a longlong braindamage, started
	using G450 stuff everywhere, it become more and more usable.
	for dual fb X it is stable and usable now.
	
	G400 drivers also work, but matroxset aint switching second head
	to monitor output, neither does anything else. It remains blank.

elmer.


