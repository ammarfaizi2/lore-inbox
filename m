Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266663AbUIENVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266663AbUIENVs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 09:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266657AbUIENVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 09:21:47 -0400
Received: from mailgate.uni-paderborn.de ([131.234.22.32]:54149 "EHLO
	mailgate.uni-paderborn.de") by vger.kernel.org with ESMTP
	id S266663AbUIENVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 09:21:40 -0400
Message-ID: <413B121B.2070101@upb.de>
Date: Sun, 05 Sep 2004 15:18:19 +0200
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4.2) Gecko/20040426
X-Accept-Language: de, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: why do i get "Stale NFS file handle" for hours?
References: <chdp06$e56$1@sea.gmane.org>	 <1094348385.13791.119.camel@lade.trondhjem.org>  <413A7119.2090709@upb.de>	 <1094349744.13791.128.camel@lade.trondhjem.org>  <413A789C.9000501@upb.de> <1094353267.13791.156.camel@lade.trondhjem.org>
In-Reply-To: <1094353267.13791.156.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-UNI-PB_FAK-EIM-MailScanner-Information: Please see http://imap.uni-paderborn.de for details
X-UNI-PB_FAK-EIM-MailScanner: Found to be clean
X-UNI-PB_FAK-EIM-MailScanner-SpamCheck: not spam, SpamAssassin (score=-4.275,
	required 4, AUTH_EIM_USER -5.00, RCVD_IN_NJABL 0.10,
	RCVD_IN_NJABL_DIALUP 0.53, RCVD_IN_SORBS 0.10)
X-MailScanner-From: skoehler@upb.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So, there are 3 possibilities:
> 
>  1) You are exporting a non-supported filesystem, (e.g. FAT). See the
> FAQ on http://nfs.sourceforge.org.

I'm exporting a reiserfs.

>  2) A bug in your initscripts is causing the table of exports to be
> clobbered. Running "exportfs" in legacy 2.4 mode (without having the
> nfsd filesystem mounted on /proc/fs/nfsd) appears to be broken for me at
> least...

So there should be a filesystem mounted to /proc/fs/nfsd? This isn't the 
case on my machine. Should the init-script do a simple "mount -t nfsd 
none /proc/fs/nfsd"? Than this would be a Bug of my distribution (Gentoo).

