Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbTJTJQl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 05:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbTJTJQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 05:16:40 -0400
Received: from indigo.cs.bgu.ac.il ([132.72.42.23]:56464 "EHLO
	indigo.cs.bgu.ac.il") by vger.kernel.org with ESMTP id S262458AbTJTJQg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 05:16:36 -0400
Date: Mon, 20 Oct 2003 11:12:07 +0200 (IST)
From: Nir Tzachar <tzachar@cs.bgu.ac.il>
To: linux-fsdevel@vger.kernel.org
cc: linux-kernel@vger.kernel.org
Subject: srfs - a new file system.
In-Reply-To: <Pine.GSO.4.44.0310070757400.4688-100000@sundance.cse.ucsc.edu>
Message-ID: <Pine.LNX.4.44_heb2.09.0310201031150.20172-100000@nexus.cs.bgu.ac.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello all.

We're proud to announce the availability of a _proof of concept_ file
system, called srfs. ( http://www.cs.bgu.ac.il/~srfs/ ).
a quick overview: [from the home page]
srfs is a global file system designed to be distributed geographicly over
multiple locations and provide a consistent, high available and durable
infrastructure for information.

Started as a research project into file systems and self-stabilization in
Ben Gurion University of the Negev Department of Computer Science, the
project aims to integrate self-stabilization methods and algorithms into
the file (and operation) systems to provide a system with a desired
behavior in the presence of transient faults.

Based on layered self-stabilizing algorithms, provide a tree replication
structure based on auto-discovery of servers using local and global IP
multicasting. The tree structure is providing the command and timing
infrastructure required for a distributed file system.

The project is basically divided into two components:
1) a kernel module, which provides the low level functionality, and
   disk management.
2) a user space caching daemon, which provide the stabilization and
   replication properties of the file system.
these two components communicate via a character device.

more info on the system architecture can be find on the web page, and
here: http://www.cs.bgu.ac.il/~tzachar/srfs.pdf

We hope some will find this interesting enough to take for a test drive,
and wont mind the latencies ( currently, the caching daemon is a bit slow.
hopefully, we will improve it in the future. )
anyway, please keep in mind this is a very early version that only works,
and keeps the stabilization properties. no posix compliance whatsoever...

the code contains several hacks and design flaws that we're aware of,
and probably many that we're not... so please be gentle ;)

if someone found this interesting, please contact us with ur insights.
cheers,
the srfs team.

p.s I would like to thank all members of this mailing list (fsdevel), for
ur continual help with problems we encountered during the development.
thanks guys (and girls???).

========================================================================
nir.


