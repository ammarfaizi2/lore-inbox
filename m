Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbUCBPJw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 10:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbUCBPJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 10:09:52 -0500
Received: from 82-69-47-17.dsl.in-addr.zen.co.uk ([82.69.47.17]:53377 "EHLO
	brain.pulsesol.com") by vger.kernel.org with ESMTP id S261667AbUCBPJs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 10:09:48 -0500
Date: Tue, 2 Mar 2004 15:09:47 +0000
From: Antony Gelberg <antony@antgel.co.uk>
To: linux-kernel@vger.kernel.org
Cc: debian-user@lists.debian.org
Subject: Sony AIT ATAPI in 2.4.24
Message-ID: <20040302150947.GC2276@brain.pulsesol.com>
Mail-Followup-To: Antony Gelberg <antony@antgel.co.uk>,
	linux-kernel@vger.kernel.org, debian-user@lists.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

We have a server into which we've put a Sony AITi130a/S tape drive.
Recompiled the kernel (2.4.24) to include ATAPI TAPE.  On reboot, the logs
indicate recognition of the drive:
hdd: ~AÀ~AÀ~AÀ~AÀ~AÀ~AÀ~AÀ~AÀ~AÀ~AÀ~AÀ~AÀ~AÀ~AÀ~AÀ~AÀ~AÀ~AÀ~AÀ~A, ATAPI
TAPE drive
hdd: attached ide-tape driver.
ide-tape: ht0: I/O error, pc = 12, key =  0, asc = c0, ascq = 81
ide-tape: ht0: can't get INQUIRY results
ide-tape: ht0: I/O error, pc = 1a, key =  0, asc = c0, ascq = 81
ide-tape: Can't get tape parameters - assuming some default values
ide-tape: ht0: I/O error, pc = 1a, key =  0, asc = c0, ascq = 81
ide-tape: Can't get block descriptor
ide-tape: hdd <-> ht0: 450KBps, 6*26kB buffer, 4394kB pipeline, 110ms
tDSC

With no tape in the drive, the above doesn't happen - the drive is not
detected as far as I can see.

Subequent attempts to use the drive result in error messages like:
Mar  2 15:07:38 server kernel: hdd: ATAPI reset complete
Mar  2 15:07:38 server kernel: ide-tape: ht0: I/O error, pc =  1, key =
0, asc = c0, ascq = 81
Mar  2 15:09:38 server kernel: ide-tape: ht0: DSC timeout

I was hoping that someone who knows the ide-tape stuff is around, and
could help me with what those hex values and other errors mean, and even
whether there is a chance that this drive is not supported.  I'm going
to upgrade to 2.6.3, but need to wait for an outage.

Please CC me as I'm not subscribed.

Antony
