Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbTJMP3e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 11:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbTJMP3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 11:29:34 -0400
Received: from pat.uio.no ([129.240.130.16]:61119 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261776AbTJMP3d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 11:29:33 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16266.50390.93346.47602@charged.uio.no>
Date: Mon, 13 Oct 2003 11:29:26 -0400
To: Frank Cusack <fcusack@fcusack.com>
Cc: Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: nfs fstat st_blocks overreporting
In-Reply-To: <20031013075316.A16032@google.com>
References: <20031013075316.A16032@google.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Frank Cusack <fcusack@fcusack.com> writes:

     > While you know I disagree that s_blocksize should be wtmult
     > (ie, it is wtmult?wtmult:512 and I think it should be
     > MAX(rsize,wsize)), in any event the blocks used reporting is
     > incorrect in that it assumes a 512 byte blocksize.

Frank,

     man 2 stat

  i_blocks a.k.a. stat->st_blocks is _defined_ to be in 512byte
units. It bears no relation to the st_blksize. If you don't like that,
spec then by all means appeal to the POSIX committee that wrote
it. (You probably wouldn't be the first to do so)

  Pending the outcome of such an appeal, though, the patch must be
rejected...

Cheers,
  Trond
