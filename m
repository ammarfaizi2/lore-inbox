Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319097AbSHGS3M>; Wed, 7 Aug 2002 14:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319105AbSHGS3M>; Wed, 7 Aug 2002 14:29:12 -0400
Received: from pg-fw.paradigmgeo.com ([192.117.235.33]:11889 "EHLO
	ntserver2.geodepth.com") by vger.kernel.org with ESMTP
	id <S319097AbSHGS3K>; Wed, 7 Aug 2002 14:29:10 -0400
Message-ID: <EE83E551E08D1D43AD52D50B9F511092E114E4@ntserver2>
From: Gregory Giguashvili <Gregoryg@ParadigmGeo.com>
To: "'Jesse Pollard'" <pollard@tomcat.admin.navo.hpc.mil>,
       "'trond.myklebust@fys.uio.no'" <trond.myklebust@fys.uio.no>
Cc: "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: RE: O_SYNC option doesn't work (2.4.18-3)
Date: Wed, 7 Aug 2002 21:30:04 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Only file level locking is permitted. You can only open the 
>file IF you get
>the lock. And be sure to close the file before releasing the 
>lock. Make sure
>that all accesses to the file use the SAME lock technique.
You need a file descriptor to lock the file, don't you? That's assuming that
you intend to use lockd locking.

>We just don't mix multiple client access to the same file, unless everybody

>is only reading that file.
When the writer closes the file, how do you make the readers see the latest
changes (assuming that you always open/close files per transaction type).

Thanks a lot.
Giga
