Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262997AbTJJQJy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 12:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262987AbTJJQIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 12:08:30 -0400
Received: from pat.uio.no ([129.240.130.16]:16810 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262963AbTJJQIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 12:08:05 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16262.55644.581657.936392@charged.uio.no>
Date: Fri, 10 Oct 2003 12:07:56 -0400
To: Jamie Lokier <jamie@shareable.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Misc NFSv4 (was Re: statfs() / statvfs() syscall ballsup...)
In-Reply-To: <20031010155322.GH28795@mail.shareable.org>
References: <Pine.LNX.4.44.0310091525200.20936-100000@home.osdl.org>
	<3F85ED01.8020207@redhat.com>
	<20031010002248.GE7665@parcelfarce.linux.theplanet.co.uk>
	<20031010044909.GB26379@mail.shareable.org>
	<16262.17185.757790.524584@charged.uio.no>
	<20031010123732.GA28224@mail.shareable.org>
	<16262.47147.943477.24070@charged.uio.no>
	<20031010143553.GA28795@mail.shareable.org>
	<16262.53512.249701.158271@charged.uio.no>
	<20031010155322.GH28795@mail.shareable.org>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Jamie Lokier <jamie@shareable.org> writes:

     > An uber-cool capability would be notification of sub-files to
     > any depth.  You can't imagine how tedious it has been watching
     > a makefile take 5 minutes _just_ to run the "find" command on a
     > source tree to find newer files than the last successful make.
     > (It was a big tree).  That was the optimised makefile.  Without
     > the "find" command, make's own dependency logic took 20 minutes
     > to do the same thing.

     > With any depth notifications, that would be eliminated to
     > roughly zero time, and just running the few compile commands
     > that are needed.

In the very long term (post NFSv4.1), we're investigating something
even more cool: 'WRITE' delegation of directories could allow you to
work in a quasi-disconnected mode on all entries plus sub-entries
(files, subdirs,....).
You could do your compilation entirely locally (backed either by
memory or cachefs) and then just flush the final results out to the
server.

AFS has, of course, had similar capabilities for some time, but I'm
not sure if they have the delegation recall feature. IIRC, their
disconnected operation overwrites whatever changes have been made on
the server when your client reconnects.

Cheers,
  Trond
