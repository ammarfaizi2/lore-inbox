Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264142AbTLIIoc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 03:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266154AbTLIIng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 03:43:36 -0500
Received: from pat.uio.no ([129.240.130.16]:6574 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S266152AbTLIImM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 03:42:12 -0500
To: Philippe Troin <phil@fifi.org>
Cc: Kenny Simpson <theonetruekenny@yahoo.com>, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
Subject: Re: [NFS client] NFS locks not released on abnormal process termination
References: <20031208033933.16136.qmail@web20024.mail.yahoo.com>
	<shszne3risb.fsf@charged.uio.no> <877k17rzai.fsf@ceramic.fifi.org>
	<1070913367.2941.137.camel@nidelv.trondhjem.org>
	<87llpms8yr.fsf@ceramic.fifi.org>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 09 Dec 2003 03:42:02 -0500
In-Reply-To: <87llpms8yr.fsf@ceramic.fifi.org>
Message-ID: <shsekvetmat.fsf@guts.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Portable Code)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.9, required 12,
	BAYES_00 -4.90)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Philippe Troin <phil@fifi.org> writes:

     > From my reading of the patch, it supersedes the old patch, and
     > is only
     > necessary on the client. Is also does not compile :-)

Yeah, I admit I didn't test it out...

     > Here's an updated patch which does compile.

Thanks.

     > I am still running tests, but so far it looks good (that is all
     > locks are freed when a process with locks running on a NFS
     > client is killed).

Good...

There are still 2 other issues with the generic POSIX locking code.
Both issues have to do with CLONE_VM and have been raised on
linux-kernel & linux-fsdevel. Unfortunately they met with no response,
so I'm unable to pursue...

Cheers,
  Trond
