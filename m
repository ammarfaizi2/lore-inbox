Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318764AbSHGRPb>; Wed, 7 Aug 2002 13:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318783AbSHGRPb>; Wed, 7 Aug 2002 13:15:31 -0400
Received: from pat.uio.no ([129.240.130.16]:9427 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S318764AbSHGRPb>;
	Wed, 7 Aug 2002 13:15:31 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15697.22155.257411.150056@charged.uio.no>
Date: Wed, 7 Aug 2002 19:19:07 +0200
To: Gregory Giguashvili <Gregoryg@ParadigmGeo.com>
Cc: "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: RE: O_SYNC option doesn't work (2.4.18-3)
In-Reply-To: <EE83E551E08D1D43AD52D50B9F511092E114E0@ntserver2>
References: <EE83E551E08D1D43AD52D50B9F511092E114E0@ntserver2>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Gregory Giguashvili <Gregoryg@ParadigmGeo.com> writes:

    >> The latter are found on ftp.kernel.org and mirrors...
     > Are you saying that this problem is non-existent in the latest
     > kernel patches? Can you, please, point to at least one of them?

No. I said that reporting bugs on RedHat-specific kernels should be
done to RedHat rather than to this list.

As for O_SYNC, AFAICS there are no bugs in the standard
kernel. However if you are thinking that O_SYNC means that you can
write simultaneously to the same file from 2 different clients, then
the answer is "the NFS protocol won't allow you to do that".
The *only* method of ensuring cache consistency in such a case is to
use POSIX file locking.

Cheers,
  Trond
