Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbWFUHUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbWFUHUA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 03:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWFUHUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 03:20:00 -0400
Received: from mail.mnsspb.ru ([84.204.75.2]:1952 "EHLO mail.mnsspb.ru")
	by vger.kernel.org with ESMTP id S1751234AbWFUHUA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 03:20:00 -0400
From: Kirill Smelkov <kirr@mns.spb.ru>
Organization: MNS
To: David Howells <dhowells@redhat.com>
Subject: [PATCH] doc: fix typos in Documentation/memory-barriers.txt
Date: Wed, 21 Jun 2006 11:20:55 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606211120.56953.kirr@mns.spb.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for excellent article!
While reading it I discovered a few typos.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 4710845..638b686 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -282,7 +282,7 @@ Memory barriers come in four basic varie
      A write barrier is a partial ordering on stores only; it is not required
      to have any effect on loads.
 
-     A CPU can be viewed as as commiting a sequence of store operations to the
+     A CPU can be viewed as commiting a sequence of store operations to the
      memory system as time progresses.  All stores before a write barrier will
      occur in the sequence _before_ all the stores after the write barrier.
 
@@ -484,7 +484,7 @@ lines.  The pointer P might be stored in
 variable B might be stored in an even-numbered cache line.  Then, if the
 even-numbered bank of the reading CPU's cache is extremely busy while the
 odd-numbered bank is idle, one can see the new value of the pointer P (&B),
-but the old value of the variable B (1).
+but the old value of the variable B (2).
 
 
 Another example of where data dependency barriers might by required is where a
@@ -744,7 +744,7 @@ some effectively random order, despite t
 	                                        :       :
 
 
-If, however, a read barrier were to be placed between the load of E and the
+If, however, a read barrier were to be placed between the load of B and the
 load of A on CPU 2:
 
 	CPU 1			CPU 2
@@ -1461,7 +1461,7 @@ instruction itself is complete.
 
 On a UP system - where this wouldn't be a problem - the smp_mb() is just a
 compiler barrier, thus making sure the compiler emits the instructions in the
-right order without actually intervening in the CPU.  Since there there's only
+right order without actually intervening in the CPU.  Since there's only
 one CPU, that CPU's dependency ordering logic will take care of everything
 else.
 
@@ -1640,7 +1640,7 @@ functions:
 
      The PCI bus, amongst others, defines an I/O space concept - which on such
      CPUs as i386 and x86_64 cpus readily maps to the CPU's concept of I/O
-     space.  However, it may also mapped as a virtual I/O space in the CPU's
+     space.  However, it may also be mapped as a virtual I/O space in the CPU's
      memory map, particularly on those CPUs that don't support alternate
      I/O spaces.
 


