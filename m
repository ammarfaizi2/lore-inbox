Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757345AbWKWKdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757345AbWKWKdH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 05:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757347AbWKWKdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 05:33:07 -0500
Received: from mx3.cs.washington.edu ([128.208.3.132]:41391 "EHLO
	mx3.cs.washington.edu") by vger.kernel.org with ESMTP
	id S1757345AbWKWKdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 05:33:03 -0500
Date: Thu, 23 Nov 2006 02:33:02 -0800 (PST)
From: David Rientjes <rientjes@cs.washington.edu>
To: d binderman <dcb314@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fs: remove unused variable
In-Reply-To: <BAY107-F2847307957C37B16EA55729CE20@phx.gbl>
Message-ID: <Pine.LNX.4.64N.0611230231190.18515@attu4.cs.washington.edu>
References: <BAY107-F2847307957C37B16EA55729CE20@phx.gbl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removed unused 'have_pt_gnu_stack' variable.

Reported by David Binderman <dcb314@hotmail.com>

Signed-off-by: David Rientjes <rientjes@cs.washington.edu>
---
 fs/binfmt_elf.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 79b05a1..8bdefa2 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -545,7 +545,7 @@ static int load_elf_binary(struct linux_
 	unsigned long reloc_func_desc = 0;
 	char passed_fileno[6];
 	struct files_struct *files;
-	int have_pt_gnu_stack, executable_stack = EXSTACK_DEFAULT;
+	int executable_stack = EXSTACK_DEFAULT;
 	unsigned long def_flags = 0;
 	struct {
 		struct elfhdr elf_ex;
@@ -708,7 +708,6 @@ static int load_elf_binary(struct linux_
 				executable_stack = EXSTACK_DISABLE_X;
 			break;
 		}
-	have_pt_gnu_stack = (i < loc->elf_ex.e_phnum);
 
 	/* Some simple consistency checks for the interpreter */
 	if (elf_interpreter) {
