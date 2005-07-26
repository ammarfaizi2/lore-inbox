Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261989AbVGZSMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbVGZSMU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 14:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbVGZSJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 14:09:50 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51847 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261989AbVGZSHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 14:07:38 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 18/23] machine_shutdown: Typo fix to actually allow
 specifying which cpu to reboot on
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
	<m1iryxeb4t.fsf@ebiederm.dsl.xmission.com>
	<m1ek9leb0h.fsf_-_@ebiederm.dsl.xmission.com>
	<m1ack9eaux.fsf_-_@ebiederm.dsl.xmission.com>
	<m164uxear0.fsf_-_@ebiederm.dsl.xmission.com>
	<m11x5leaml.fsf_-_@ebiederm.dsl.xmission.com>
	<m1wtndcvwe.fsf_-_@ebiederm.dsl.xmission.com>
	<m1sly1cvnd.fsf_-_@ebiederm.dsl.xmission.com>
	<m1oe8pcvii.fsf_-_@ebiederm.dsl.xmission.com>
	<m1k6jdcvgk.fsf_-_@ebiederm.dsl.xmission.com>
	<m1fyu1cvd7.fsf_-_@ebiederm.dsl.xmission.com>
	<m1br4pcva4.fsf_-_@ebiederm.dsl.xmission.com>
	<m17jfdcv79.fsf_-_@ebiederm.dsl.xmission.com>
	<m13bq1cv3k.fsf_-_@ebiederm.dsl.xmission.com>
	<m1y87tbgeo.fsf_-_@ebiederm.dsl.xmission.com>
	<m1u0ihbg85.fsf_-_@ebiederm.dsl.xmission.com>
	<m1pst5bg5u.fsf_-_@ebiederm.dsl.xmission.com>
	<m1ll3tbg2r.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 26 Jul 2005 12:07:01 -0600
In-Reply-To: <m1ll3tbg2r.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Tue, 26 Jul 2005 12:03:08 -0600")
Message-ID: <m1hdehbfwa.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This appears to be a typo I introduced when cleaning
this code up earlier. Ooops.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 arch/i386/kernel/reboot.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

75a1cfd3c44dbea3af15e04704c7db2be70478c7
diff --git a/arch/i386/kernel/reboot.c b/arch/i386/kernel/reboot.c
--- a/arch/i386/kernel/reboot.c
+++ b/arch/i386/kernel/reboot.c
@@ -284,7 +284,7 @@ void machine_shutdown(void)
 	reboot_cpu_id = 0;
 
 	/* See if there has been given a command line override */
-	if ((reboot_cpu_id != -1) && (reboot_cpu < NR_CPUS) &&
+	if ((reboot_cpu != -1) && (reboot_cpu < NR_CPUS) &&
 		cpu_isset(reboot_cpu, cpu_online_map)) {
 		reboot_cpu_id = reboot_cpu;
 	}
