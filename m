Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318766AbSHGRid>; Wed, 7 Aug 2002 13:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318777AbSHGRid>; Wed, 7 Aug 2002 13:38:33 -0400
Received: from pg-fw.paradigmgeo.com ([192.117.235.33]:58729 "EHLO
	ntserver2.geodepth.com") by vger.kernel.org with ESMTP
	id <S318766AbSHGRid>; Wed, 7 Aug 2002 13:38:33 -0400
Message-ID: <EE83E551E08D1D43AD52D50B9F511092E114E1@ntserver2>
From: Gregory Giguashvili <Gregoryg@ParadigmGeo.com>
To: "'trond.myklebust@fys.uio.no'" <trond.myklebust@fys.uio.no>
Cc: "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: RE: O_SYNC option doesn't work (2.4.18-3)
Date: Wed, 7 Aug 2002 20:39:27 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>However if you are thinking that O_SYNC means that you can
>write simultaneously to the same file from 2 different clients, then
>the answer is "the NFS protocol won't allow you to do that".
>The *only* method of ensuring cache consistency in such a case is to
>use POSIX file locking.
I thought that O_SYNC opens the file for synchronous I/O by blocking writes
till the data is written to the disk. In case of NFS mounted disk, this
should work only if "sync" option is present both in export and mount
options, shouldn't it?

In what I see, a simple test doesn't work in the expected way, which is one
client writes to a file opened with O_SYNC on a drive mounted with sync
option and the other client cannot immediatelly see the written data.
Are you saying that this is the way it should be?

Thanks a lot.
Giga


