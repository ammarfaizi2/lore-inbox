Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315372AbSGIOGV>; Tue, 9 Jul 2002 10:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315374AbSGIOGU>; Tue, 9 Jul 2002 10:06:20 -0400
Received: from pat.uio.no ([129.240.130.16]:59874 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S315372AbSGIOGT>;
	Tue, 9 Jul 2002 10:06:19 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15658.61035.450205.832652@charged.uio.no>
Date: Tue, 9 Jul 2002 16:08:43 +0200
To: root@chaos.analogic.com
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.19-rc1/2.5.25 provide dummy fsync() routine for directories on NFS mounts
In-Reply-To: <Pine.LNX.3.95.1020709095544.27285A-100000@chaos.analogic.com>
References: <200207091549.15913.trond.myklebust@fys.uio.no>
	<Pine.LNX.3.95.1020709095544.27285A-100000@chaos.analogic.com>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Richard B Johnson <root@chaos.analogic.com> writes:

     > I think code that opens a directory as a file is broken. We
     > have opendir() for that and it returns a DIR pointer, not a
     > file descriptor.  If the directory was properly opened, one
     > would never attempt to fsync() it.

 fsync() is supported on directories on local filesystems as a way of
ensuring that changes (due to file creation etc) are committed to
disk. Where is the POSIX violation in that?

 There is no reason why NFS, which ensures this anyway, should
not adhere to this convention.

Cheers,
  Trond
