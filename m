Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262932AbUF3VsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbUF3VsE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 17:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263001AbUF3VsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 17:48:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:44429 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262932AbUF3Vr7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 17:47:59 -0400
Date: Wed, 30 Jun 2004 14:47:57 -0700 (PDT)
From: Bryce Harrington <bryce@osdl.org>
To: <ltp-list@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
cc: <testdev@osdl.org>, <stp-devel@lists.sourceforge.net>
Subject: Wrapped-LTP package from STP available 
Message-ID: <Pine.LNX.4.33.0406301440580.2234-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If anyone is interested in running the LTP test suite exactly as it
works in OSDL's STP, I've prepared a package of what we use that will
run without requiring a full STP install.

In Short:
=========
   * Go to http://sourceforge.net/projects/stp/
   * Go to the 'stp-tests-lite' link in the Files area
   * Get test_execution_wrapper-1.tar.gz
     + Untar it
     + Install ala 'perl Makefile.PL; make; make install'
   * Get ltp-wrapped-20040506.tgz
     + Untar it
     + cd into the LTP directory
     + execute it via `sh ./wrap.sh`
   * Results and logs will be in the results/ directory


Description:
============
The ltp-wrapped package is basically a verbatim copy of the ltp-full
release, plus a few extra scripts for using it within automated testing
frameworks, gather logs, and generate reports.

The test_execution_wrapper package is a collection of a few bits of STP
that the ltp-wrapped package requires.  Specifically: a shell script to
set some environment variables, and a timeout handler script that kills
the test if it runs past its allotted run time.

Most of this is really only relevant to STP - if you're just interested
in running LTP straight, this wrapped ltp doesn't add anything special.
But if you want to be able to compare your runs specifically with LTP
runs in the STP system, this lets you generate the exact same set of
reports and behaviors as would happen on an STP client machine.


Ref.:
=====
    http://ltp.sourceforge.net     - LTP Home
    http://www.osdl.org/stp/       - for STP users
    http://developer.osdl.org/stp/ - for STP developers

    bk://developer.osdl.org:/var/bk/stp-tests/LTP


If you find this useful, or have comments or questions, just let me
know!

Bryce




