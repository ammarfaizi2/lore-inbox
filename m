Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268189AbUIFQEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268189AbUIFQEt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 12:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268193AbUIFQEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 12:04:05 -0400
Received: from pat.uio.no ([129.240.130.16]:34277 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S268189AbUIFP7b convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 11:59:31 -0400
Subject: Re: why do i get "Stale NFS file handle" for hours?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Sven =?ISO-8859-1?Q?K=F6hler?= <skoehler@upb.de>,
       linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
In-Reply-To: <1094464633.3986.36.camel@imladris.demon.co.uk>
References: <chdp06$e56$1@sea.gmane.org>
	 <1094348385.13791.119.camel@lade.trondhjem.org>  <413A7119.2090709@upb.de>
	 <1094349744.13791.128.camel@lade.trondhjem.org>  <413A789C.9000501@upb.de>
	 <1094353267.13791.156.camel@lade.trondhjem.org>
	 <1094464633.3986.36.camel@imladris.demon.co.uk>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1094486357.8342.12.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 06 Sep 2004 11:59:17 -0400
Content-Transfer-Encoding: 8BIT
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På må , 06/09/2004 klokka 05:57, skreiv David Woodhouse:

> The fact that we require a persistent table of exports at all, and can't
> call back to mountd to authenticate 'new' clients instead of just
> telling them to sod off if the kernel doesn't already know about them,
> is considered by some to be a bug in knfsd. 

That should have been fixed in 2.6.x. If you do mount /proc/fs/nfsd, and
use a recent enough version of mountd, then knfsd can and will work
without any extra help from exportfs.

The one problem I have found with this implementation is that it relies
very heavily on reverse-DNS lookups, so it may give unexpected results
if you have more than one name for your client. I can't see why that
shouldn't be fixable, though...

Cheers,
  Trond

