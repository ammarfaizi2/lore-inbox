Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbTKGEqw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 23:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbTKGEqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 23:46:52 -0500
Received: from pat.uio.no ([129.240.130.16]:61363 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261376AbTKGEqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 23:46:51 -0500
To: Kris Kennaway <kris@freebsd.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS Locking violates protocol spec (incompatible with FreeBSD)
References: <20031107041051.GA4065@rot13.obsecurity.org>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 06 Nov 2003 23:46:48 -0500
In-Reply-To: <20031107041051.GA4065@rot13.obsecurity.org>
Message-ID: <shsk76c3hvr.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Kris Kennaway <kris@freebsd.org> writes:


     > contains more details about this problem, including a
     > workaround for FreeBSD to limit the cookie size to 8 bytes.
     > Obviously, it would be better for this bug to be fixed in
     > Linux, since Linux is non-conformant to the protocol.

Yes. I saw a mail with a justification for why you want to be able to
wait on > 2^64 outstanding lock requests to a single lockd server, and
was highly amused.
I'm still hoping the person who decided that he needed 1024 byte
long cookies will own up some day. OTOH, he might still be busy
testing his locking code for cookie wraparound...


Anyhow, a patch exists (written by Greg Banks), and can be found as

 http://www.fys.uio.no/~trondmy/src/Linux-2.4.x/2.4.23-pre9/linux-2.4.23-01-fix_osx.dif


No. It does not extend the cookie size to 1k...

Cheers,
  Trond
