Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267561AbUIFHrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267561AbUIFHrr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 03:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267578AbUIFHrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 03:47:47 -0400
Received: from main.gmane.org ([80.91.224.249]:26837 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S267561AbUIFHra (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 03:47:30 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: why do i get "Stale NFS file handle" for hours?
Date: Mon, 06 Sep 2004 16:47:14 +0900
Message-ID: <chh4m7$scm$1@sea.gmane.org>
References: <chdp06$e56$1@sea.gmane.org>	 <1094348385.13791.119.camel@lade.trondhjem.org>  <413A7119.2090709@upb.de>	 <1094349744.13791.128.camel@lade.trondhjem.org>  <413A789C.9000501@upb.de>	 <1094353267.13791.156.camel@lade.trondhjem.org>  <413B121B.2070101@upb.de> <1094415006.8081.6.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: j110113.ppp.asahi-net.or.jp
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040627
X-Accept-Language: bg, en, ja, ru, de
In-Reply-To: <1094415006.8081.6.camel@lade.trondhjem.org>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Cc: nfs@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
>>So there should be a filesystem mounted to /proc/fs/nfsd? This isn't the 
>>case on my machine. Should the init-script do a simple "mount -t nfsd 
>>none /proc/fs/nfsd"? Than this would be a Bug of my distribution (Gentoo).
Well, I am on Gentoo as well, and it seems that it is mounted on /proc/fs/nfs.

However `cat /proc/fs/nfs/exports` showed only one of 5 exported dirs on my server.
It has been a few weeks since last restart (and NFS restart).
`/etc/init.d/nfs restart` or `exportfs -a` fixed it.

> Yes... See the manpage for "exportfs".

Had a (first) look at it, but I still cannod understand what is the difference
between the "-r" and "-a" option...
The output on my system from both `exportfs -rv` and `exportfs -av` is the same.

Kalin.

-- 
 || ~~~~~~~~~~~~~~~~~~~~~~ ||
(  ) http://ThinRope.net/ (  )
 || ______________________ ||

