Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262864AbTKJEgK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 23:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262868AbTKJEgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 23:36:10 -0500
Received: from pat.uio.no ([129.240.130.16]:16112 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262864AbTKJEgK (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 23:36:10 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Andrew Morton <akpm@osdl.org>,
       Burton Windle <bwindle@fint.org>, <Linux-kernel@vger.kernel.org>
Subject: Re: slab corruption in test9 (NFS related?)
References: <Pine.LNX.4.44.0311092007451.3002-100000@home.osdl.org>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 09 Nov 2003 23:36:00 -0500
In-Reply-To: <Pine.LNX.4.44.0311092007451.3002-100000@home.osdl.org>
Message-ID: <shs7k28vo0f.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Linus Torvalds <torvalds@osdl.org> writes:

     > In other words, your patch certainly looks obviously correct,
     > but it also looks _so_ obviously correct that my alarm bells
     > are going off. If the code was quite that broken at counting
     > dentries, how the hell did it ever work AT ALL?

Given that d_free() now uses rcu, and hence defers the actual call to
kmem_cache_free(), might that not suffice to explain why actual
consequences are rare?

Cheers,
  Trond
