Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319279AbSHGTe1>; Wed, 7 Aug 2002 15:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319280AbSHGTe1>; Wed, 7 Aug 2002 15:34:27 -0400
Received: from pat.uio.no ([129.240.130.16]:19678 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S319279AbSHGTe0>;
	Wed, 7 Aug 2002 15:34:26 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15697.30489.765404.126474@charged.uio.no>
Date: Wed, 7 Aug 2002 21:38:01 +0200
To: Gregory Giguashvili <Gregoryg@ParadigmGeo.com>
Cc: "'trond.myklebust@fys.uio.no'" <trond.myklebust@fys.uio.no>,
       "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: RE: O_SYNC option doesn't work (2.4.18-3)
In-Reply-To: <EE83E551E08D1D43AD52D50B9F511092E114E3@ntserver2>
References: <EE83E551E08D1D43AD52D50B9F511092E114E3@ntserver2>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Gregory Giguashvili <Gregoryg@ParadigmGeo.com> writes:

     > File locking, meaning lockd? There are so many problems with
     > file locking in heterogeneous environments that we were moving
     > towards dropping its usage.  Instead, we planned to use some
     > home grown TCP based lock server mechanism.

     > I understand that locking file flushes NFS cache, isn't it? Why
     > can't it be flushed by O_SYNC and "sync" options presence? This
     > would make the life much easier for programmers...

Tough. The above is not part of the O_SYNC spec on any platform and I
have no intention of implementing it.

The sort of thing you would like to do will be possible with O_DIRECT
(which is a design to allow user programs to manage their own
caches). That has yet to be integrated into the standard kernel
though.

Cheers,
  Trond
