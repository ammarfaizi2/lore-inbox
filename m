Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318767AbSHGSXp>; Wed, 7 Aug 2002 14:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318771AbSHGSXo>; Wed, 7 Aug 2002 14:23:44 -0400
Received: from pg-fw.paradigmgeo.com ([192.117.235.33]:48496 "EHLO
	ntserver2.geodepth.com") by vger.kernel.org with ESMTP
	id <S318767AbSHGSXn>; Wed, 7 Aug 2002 14:23:43 -0400
Message-ID: <EE83E551E08D1D43AD52D50B9F511092E114E3@ntserver2>
From: Gregory Giguashvili <Gregoryg@ParadigmGeo.com>
To: "'trond.myklebust@fys.uio.no'" <trond.myklebust@fys.uio.no>
Cc: "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: RE: O_SYNC option doesn't work (2.4.18-3)
Date: Wed, 7 Aug 2002 21:24:37 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Furthermore, even with 'noac' they *all* have problems with races in
>the sort of scenario you describe because there is no atomic
>GETATTR+READ operation.
>
>Bottom line: If you want the sort of data cache consistency you are
>describing, you *have* to use file locking.
File locking, meaning lockd? There are so many problems with file locking in
heterogeneous environments that we were moving towards dropping its usage.
Instead, we planned to use some home grown TCP based lock server mechanism. 

I understand that locking file flushes NFS cache, isn't it? Why can't it be
flushed by O_SYNC and "sync" options presence? This would make the life much
easier for programmers...

This means that we will never be able to drop lockd locking and at the same
time achieve file consistency via NFS?

Best,
Giga
