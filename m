Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265942AbTIJXCe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 19:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbTIJXCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 19:02:34 -0400
Received: from relay2.EECS.Berkeley.EDU ([169.229.60.28]:25037 "EHLO
	relay2.EECS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S265942AbTIJXCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 19:02:30 -0400
Subject: CQual 0.99 Released: user/kernel pointer bug finding tool
From: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       "David S. Miller" <davem@redhat.com>,
       Jeff Foster <jfoster@cs.berkeley.edu>,
       David Wagner <daw@eecs.berkeley.edu>
In-Reply-To: <20030818210513.GB3276@kroah.com>
References: <20030805103240.02221bed.khali@linux-fr.org>
	<20030805210704.GA5452@kroah.com>
	<20030806100702.78298ffe.khali@linux-fr.org>
	<1060886657.1006.7121.camel@dooby.cs.berkeley.edu>
	<20030814190954.GA2492@kroah.com>
	<1060912895.1006.7160.camel@dooby.cs.berkeley.edu>
	<20030815211329.GB4920@kroah.com>
	<1060985846.302.17.camel@dooby.cs.berkeley.edu>
	<20030815235127.GA5697@kroah.com>
	<1061168082.16691.120.camel@dooby.cs.berkeley.edu> 
	<20030818210513.GB3276@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 10 Sep 2003 16:02:08 -0700
Message-Id: <1063234934.19577.92.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Download: http://www.cs.umd.edu/~jfoster/cqual/.
Support:  cqual@cs.umd.edu.

CQual is a program verification tool that uses type-qualifier
inference to find bugs in C programs.  This release of CQual includes
support for finding user/kernel pointer bugs in the linux kernel.
CQual has already found user/kernel pointer bugs in source files that
passed through Linus' "sparse" tool without generating any warnings.
Our goals with this release are

- help kernel developers avoid user/kernel bugs
- get feedback from kernel developers for future CQual features

CQual's current main features are:

- It requires _very_ few annotations: we currently use only ~200
- It's sound: CQual verifies the _absence_ of user/kernel bugs
- It generates fewer false warnings than sparse.
- It's context-sensitve: CQual doesn't confuse different calls to the 
  same function.
- CQual allows different instances of a struct type to hold different 
  kinds of pointers (i.e. user vs. kernel)
- It can be easily extended to find new types of bugs by editing a 
  configuration file
- It's fast: CQual analyzes most files in 1-2 seconds.
- It integrates easily into the kernel checking process.

The distribution contains a KERNEL-QUICKSTART to help kernel
developers start finding user/kernel bugs quickly.  We look forward to
hearing your feedback.

CQual is currently developed by Jeff Foster, John Kodumal, Tachio
Terauchi, Rob Johnson, and many others.

Best,
Rob Johnson


