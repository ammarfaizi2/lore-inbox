Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284652AbRLPPGf>; Sun, 16 Dec 2001 10:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284653AbRLPPG0>; Sun, 16 Dec 2001 10:06:26 -0500
Received: from pat.uio.no ([129.240.130.16]:27630 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S284652AbRLPPGS>;
	Sun, 16 Dec 2001 10:06:18 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15388.47196.987305.957349@charged.uio.no>
Date: Sun, 16 Dec 2001 16:06:04 +0100
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS woes in 2.5.1-pre8
In-Reply-To: <20011215160239.A32750@flint.arm.linux.org.uk>
In-Reply-To: <20011212164334.B16377@flint.arm.linux.org.uk>
	<shsofl49mpi.fsf@charged.uio.no>
	<20011215160239.A32750@flint.arm.linux.org.uk>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Russell King <rmk@arm.linux.org.uk> writes:

     > lstat("../lib/libts_variance-0.0.so.0", 0xbffffb98) = -1 EIO
     > (Input/output error)

Ah.. Do you also get the error

   nfs_refresh_inode: inode number mismatch
   expected (blah), got (blech)

in your syslog? If so it's because the unfsd is reusing filehandles.

Cheers,
   Trond
