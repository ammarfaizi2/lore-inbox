Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264944AbTLTSx4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 13:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264958AbTLTSxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 13:53:55 -0500
Received: from alfa.fastwebnet.it ([213.140.2.55]:7348 "EHLO
	alfa.fastwebnet.it") by vger.kernel.org with ESMTP id S264944AbTLTSxw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 13:53:52 -0500
From: Willy Gardiol <willy@gardiol.org>
Reply-To: willy@gardiol.org
To: <linux-kernel@vger.kernel.org>
Subject: Promise and sparc64
Date: Sat, 20 Dec 2003 19:53:49 +0100
User-Agent: KMail/1.5.4
Cc: <linux-ide@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200312201953.50714.willy@gardiol.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


I have got an Ultra5 (sparc based, sun4u) and tried to plug both a Promise 
Ultra100tx2 (pdc20268) and a Promise FastTrack 2000 (pcd20271).

The system boots and the kernel (2.4.23) works, the two UDMA100 disks plugged 
(one per channel) on the promised works in PIO mode.

If i enable DMA on a single drive it WORKS (up to udma2 tested, with hdparm 
- -X66) 
When i enable DMA on the other channel (it does not count which one) i start 
getting many DMA errors (-20 and -22 error codes) and soon the disks hangs 
bringing the system down (but no kernel panic).

Similar, if i enable DMA on one channel then start coping data bethween the 
two channels the systems suffers the same symptoms.

Please note, both the controller and the disks have been used successfully in 
UDMA5 on a x86 system before, and now the disks positively works in mdma2 
using the onboard CMD ide controller of the Ultra5 (does not seems to be able 
to do UDMA at all)

Is this a know issue?


- -- 

! 
 Willy Gardiol - willy@gardiol.org
 www.gardiol.org
 Use linux for your freedom.

  "Linux is like a wigwam: no windows,
   no gates, Apache inside."

  "Linux è come una tenda indiana: niente finestre,
   niente porte, gli Apache dentro.

      Albert Arendsen



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/5Jq9Q9qolN/zUk4RAvTlAKCYfE2rP5bWTqPaD1yhCvpffwcEsQCgnQoF
qS/Dyo0oxVDlM4S3+SHaYTA=
=FIAW
-----END PGP SIGNATURE-----

