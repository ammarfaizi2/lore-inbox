Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316342AbSFDMXP>; Tue, 4 Jun 2002 08:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316598AbSFDMXO>; Tue, 4 Jun 2002 08:23:14 -0400
Received: from pat.uio.no ([129.240.130.16]:20632 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S316342AbSFDMXN>;
	Tue, 4 Jun 2002 08:23:13 -0400
To: Matthias Welk <welk@fokus.gmd.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nfs slowdown since 2.5.4
In-Reply-To: <200206041253.44446.welk@fokus.gmd.de>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 04 Jun 2002 14:23:07 +0200
Message-ID: <shsg0032pxw.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Matthias Welk <welk@fokus.gmd.de> writes:

     > Hi, since 2.5.4 I noticed a big slowdown in nfs.  It seems that
     > this is related to the changes in the nfs-lookup code, because
     > now most traffic via nfs is for lookup- and getattr-calls as
     > you can see in the attached tcpdump log.  I'v also attached a
     > log of nfsstat, which shows this problem too.

Tough... Those extra checks are needed in order to ensure data cache
correctness on file open().

If you think you don't need them because the files that you are
reading are known never to change on the server, you can try mounting
with the 'nocto' mount option.

Cheers,
  Trond
