Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132429AbRDCS5b>; Tue, 3 Apr 2001 14:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132434AbRDCS5V>; Tue, 3 Apr 2001 14:57:21 -0400
Received: from cc946626-a.vron1.nj.home.com ([24.5.103.153]:4612 "EHLO
	tela.bklyn.org") by vger.kernel.org with ESMTP id <S132429AbRDCS5K>;
	Tue, 3 Apr 2001 14:57:10 -0400
Date: Tue, 3 Apr 2001 14:56:15 -0400
From: Caleb Epstein <cae@bklyn.org>
To: linux-kernel@vger.kernel.org
Subject: NFS client code slow in 2.4.3
Message-ID: <20010403145615.C1049@hagrid.bklyn.org>
Reply-To: Caleb Epstein <cae@bklyn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Organization: Brooklyn Dust Bunny Mfg.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	I am having problems with timeouts and generaly throughput in
	the 2.4.3 NFS client side code which are not present in the
	2.4.2 kernel running in the same configuraiton on the same
	hardware.  The machines are on a 100 Mbit switched local
	network with essentially no other trafic.

	In both cases, testing against a 2.4.3 NFS server (using
	knfsd).  My tests involved using "dd" to read a large file on
	an NFS mounted directory and running the "connectathon" NFS
	test suite.

	When I boot my client machine with 2.4.3, reading a 327 Mbyte
	file over NFS takes on the order of 5-6 minutes to complete.
	If I run the same command witrh the client running kernel
	2.4.2, the command completes in about 1 minute.

	Running the "cthon01" test suite, the 2.4.3 client machine
	basically hangs in the "read + write" test section and I
	didn't bother waiting for it to finish.  Again, when switching
	back to 2.4.2, the client runs through the tests quite
	quickly.

	From my tests I'm pretty convinced that something in either
	the NFS client code or the networking layer has changed which
	has drastically reduced NFS client speeds in 2.4.3.

	Is this a known problem?  Can I provide any additional
	information to help debug it?

-- 
cae at bklyn dot org | Caleb Epstein | bklyn . org | Brooklyn Dust Bunny Mfg.
