Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267505AbUIFJ5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267505AbUIFJ5T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 05:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267528AbUIFJ5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 05:57:19 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:11185 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S267505AbUIFJ5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 05:57:17 -0400
Subject: Re: why do i get "Stale NFS file handle" for hours?
From: David Woodhouse <dwmw2@infradead.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Sven =?ISO-8859-1?Q?K=F6hler?= <skoehler@upb.de>,
       linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
In-Reply-To: <1094353267.13791.156.camel@lade.trondhjem.org>
References: <chdp06$e56$1@sea.gmane.org>
	 <1094348385.13791.119.camel@lade.trondhjem.org>  <413A7119.2090709@upb.de>
	 <1094349744.13791.128.camel@lade.trondhjem.org>  <413A789C.9000501@upb.de>
	 <1094353267.13791.156.camel@lade.trondhjem.org>
Content-Type: text/plain
Message-Id: <1094464633.3986.36.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Mon, 06 Sep 2004 10:57:13 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-09-04 at 23:01 -0400, Trond Myklebust wrote:
>  2) A bug in your initscripts is causing the table of exports to be
> clobbered. Running "exportfs" in legacy 2.4 mode (without having the
> nfsd filesystem mounted on /proc/fs/nfsd) appears to be broken for me at
> least...
>  3) There is some other bug in knfsd that nobody else appears to be
> seeing.

The fact that we require a persistent table of exports at all, and can't
call back to mountd to authenticate 'new' clients instead of just
telling them to sod off if the kernel doesn't already know about them,
is considered by some to be a bug in knfsd. 

-- 
dwmw2


