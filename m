Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266139AbUIEDB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266139AbUIEDB1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 23:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266143AbUIEDB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 23:01:27 -0400
Received: from pat.uio.no ([129.240.130.16]:50161 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S266139AbUIEDBV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 23:01:21 -0400
Subject: Re: why do i get "Stale NFS file handle" for hours?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Sven =?ISO-8859-1?Q?K=F6hler?= <skoehler@upb.de>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
In-Reply-To: <413A789C.9000501@upb.de>
References: <chdp06$e56$1@sea.gmane.org>
	 <1094348385.13791.119.camel@lade.trondhjem.org>  <413A7119.2090709@upb.de>
	 <1094349744.13791.128.camel@lade.trondhjem.org>  <413A789C.9000501@upb.de>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1094353267.13791.156.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 04 Sep 2004 23:01:07 -0400
Content-Transfer-Encoding: 8BIT
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På lau , 04/09/2004 klokka 22:23, skreiv Sven Köhler:

> Sorry? Why is my server broken? I'm using kernel 2.6.8.1 with nfs-utils 
> 1.0.6 on my server, and i don't see, what should be broken.

When your server fails to work as per spec, then it is said to be
"broken" no matter what kernel/nfs-utils combination you are using.
The spec is that reboots are not supposed to clobber filehandles.

So, there are 3 possibilities:

 1) You are exporting a non-supported filesystem, (e.g. FAT). See the
FAQ on http://nfs.sourceforge.org.
 2) A bug in your initscripts is causing the table of exports to be
clobbered. Running "exportfs" in legacy 2.4 mode (without having the
nfsd filesystem mounted on /proc/fs/nfsd) appears to be broken for me at
least...
 3) There is some other bug in knfsd that nobody else appears to be
seeing.

Cheers,
  Trond

