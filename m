Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263540AbUG1UYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbUG1UYS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 16:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263467AbUG1UYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 16:24:18 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:13064 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S263555AbUG1UYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 16:24:16 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@taverner.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH] Delete cryptoloop
Date: Wed, 28 Jul 2004 20:24:06 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <ce9216$o5o$1@abraham.cs.berkeley.edu>
References: <Pine.LNX.4.58.0407211609230.19655@devserv.devel.redhat.com> <20040721230044.20fdc5ec.akpm@osdl.org> <Pine.LNX.4.58.0407212319560.13098@devserv.devel.redhat.com>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1091046246 24760 128.32.168.222 (28 Jul 2004 20:24:06 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Wed, 28 Jul 2004 20:24:06 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris  wrote:
>It would be good if we could get some further review on the issue by an 
>independent, well known cryptographer.

I'd be glad to review it if someone can point me to a clear, concise
description of the scheme (trying to extract the spec from the code
is too much work for me).

M.J. Saarinen's attack seems to be real, if that's what you're asking
about.  IV generation is important; if you choose IVs poorly, then you
can end up with some weaknesses even if the underlying block cipher is
perfectly fine.  (I noticed that some posts from, e.g., Clemens were
confused about this point.  If you use a great cipher in a bad mode of
operation, you can easily end up with an insecure system.  The existence
of an attack against such a system is not in contradiction to the security
of the underlying block cipher against chosen plaintext attacks.)
