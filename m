Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbTEMRKv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 13:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262278AbTEMRKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 13:10:51 -0400
Received: from pat.uio.no ([129.240.130.16]:38551 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262261AbTEMRKs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 13:10:48 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: David Howells <dhowells@redhat.com>, <linux-kernel@vger.kernel.org>,
       <linux-fsdevel@vger.kernel.org>, <openafs-devel@openafs.org>
Subject: Re: [PATCH] in-core AFS multiplexor and PAG support
References: <Pine.LNX.4.44.0305130929340.1678-100000@home.transmeta.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 13 May 2003 19:23:27 +0200
In-Reply-To: <Pine.LNX.4.44.0305130929340.1678-100000@home.transmeta.com>
Message-ID: <shsn0hqoj5c.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: Please contact postmaster@uio.no for more information
X-UiO-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Linus Torvalds <torvalds@transmeta.com> writes:

     > Put another way: you'd usually add the PAG's at filesystem
     > _mount_ time, no? And at that point you'd usually want to add
     > it "retroactively" to the session processes that caused the
     > mount to happen, no? Not just to the children of the mount.

Think of PAGs as "session"-style management of credentials. If you
want to add/remove a credential without sharing that operation with
all the other processes that are currently in the same session/PAG
then you change PAGs.
Otherwise, the credential operation affects all processes in the same
PAG.

Under normal circumstances, changing real uid/gid should involve
changing your PAG, but it doesn't necessarily have to do so.

Cheers,
  Trond
