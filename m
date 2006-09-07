Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161037AbWIGQmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161037AbWIGQmB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 12:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161040AbWIGQmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 12:42:01 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52667 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161037AbWIGQmA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 12:42:00 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH] NOMMU: Document NOMMU support for futexes
Date: Thu, 07 Sep 2006 17:41:24 +0100
To: torvalds@osdl.org, akpm@osdl.org, mingo@elte.hu, benh@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org, dhowells@redhat.com
Message-Id: <20060907164124.19588.23169.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Document the fact that NOMMU now supports futexes.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 Documentation/nommu-mmap.txt |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/Documentation/nommu-mmap.txt b/Documentation/nommu-mmap.txt
index 4db7c18..7714f57 100644
--- a/Documentation/nommu-mmap.txt
+++ b/Documentation/nommu-mmap.txt
@@ -138,6 +138,16 @@ mode.  The former through the usual mech
 on ramfs or tmpfs mounts.
 
 
+=======
+FUTEXES
+=======
+
+Futexes are supported in NOMMU mode if the arch supports them.  An error will
+be given if an address passed to the futex system call lies outside the
+mappings made by a process or if the mapping in which the address lies does not
+support futexes (such as an I/O chardev mapping).
+
+
 =============
 NO-MMU MREMAP
 =============
