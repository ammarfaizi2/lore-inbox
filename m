Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262693AbVBYOFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262693AbVBYOFu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 09:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262700AbVBYOFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 09:05:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:5521 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262693AbVBYOFm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 09:05:42 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <25723.1109339172@redhat.com> 
References: <25723.1109339172@redhat.com> 
To: torvalds@osdl.org, akpm@osdl.org, kwc@citi.umich.edu
Cc: linux-kernel@vger.kernel.org, nfsv4@linux-nfs.org
Subject: [PATCH] Keys: Doc update for properly sharing process keyrings patch
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Fri, 25 Feb 2005 14:05:34 +0000
Message-ID: <26049.1109340334@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch updates the documentation on the kernel keys to reflect the
fact that process keyrings will no longer change ownership when the UID and
GID of a thread change; process's don't have UIDs and GIDs in Linux, only
threads do.

This patch is contingent on the keyring sharing patch submitted a few minutes
ago.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 keys-task-doc-2611rc4.diff 
 Documentation/keys.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -uNr linux-2.6.11-rc4/Documentation/keys.txt linux-2.6.11-rc4-keys-task/Documentation/keys.txt
--- linux-2.6.11-rc4/Documentation/keys.txt	2005-01-04 11:12:42.000000000 +0000
+++ linux-2.6.11-rc4-keys-task/Documentation/keys.txt	2005-02-25 13:48:17.387035408 +0000
@@ -151,8 +151,8 @@
      by using PR_JOIN_SESSION_KEYRING. It is permitted to request an anonymous
      new one, or to attempt to create or join one of a specific name.
 
-     The ownership of the thread and process-specific keyrings changes when
-     the real UID and GID of the thread changes.
+     The ownership of the thread keyring changes when the real UID and GID of
+     the thread changes.
 
  (*) Each user ID resident in the system holds two special keyrings: a user
      specific keyring and a default user session keyring. The default session
