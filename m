Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbTIORB1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 13:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbTIORB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 13:01:26 -0400
Received: from pat.uio.no ([129.240.130.16]:55181 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261571AbTIORBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 13:01:23 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16229.61532.593859.352036@charged.uio.no>
Date: Mon, 15 Sep 2003 13:01:16 -0400
To: russell@coker.com.au
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops on 2.4.22 when mounting from broken NFS server
In-Reply-To: <200309160221.34621.russell@coker.com.au>
References: <200309131938.40177.russell@coker.com.au>
	<200309152247.20462.russell@coker.com.au>
	<shs3ceyjc4k.fsf@charged.uio.no>
	<200309160221.34621.russell@coker.com.au>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Russell Coker <russell@coker.com.au> writes:

     > I expect the NFS client to behave sensibly in the face of all
     > possible server errors, including the possibility of a hostile
     > NFS server.

No can do... There are 100s of scenarios where the server can screw
the client by giving it bogus information. You might possibly be able
to protect against a few of them, but at a heavy price in the form of
code bloat.
Neither NFSv2 nor NFSv3 are protocols that were designed to operate
safely in a hostile environment. They were designed for LANs where
servers and clients trust one another.

I agree that we shouldn't Oops though.

    >> BTW: that Oops you posted looked very much like a memory
    >> corruption problem. Were you running vanilla 2.4.22 on the
    >> client, or was it too patched?

     > It was also patched.  I will try and reproduce the error with
     > an unpatched kernel and a tcpdump running.

Please do...

Cheers,
  Trond
