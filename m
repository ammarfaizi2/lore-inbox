Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbWDEQJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWDEQJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 12:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWDEQJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 12:09:28 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:55195 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751145AbWDEQJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 12:09:27 -0400
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, Horms <horms@verge.net.au>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, fastboot@osdl.org
Subject: Re: [PATCH] kexec: typo in machine_kexec()
References: <20060404234806.GA25761@verge.net.au>
	<20060404200557.1e95bdd8.rdunlap@xenotime.net>
	<20060405055754.GA3277@verge.net.au>
	<200604051624.35358.kernel@kolivas.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 05 Apr 2006 09:49:40 -0600
In-Reply-To: <200604051624.35358.kernel@kolivas.org> (Con Kolivas's message
 of "Wed, 5 Apr 2006 16:24:34 +1000")
Message-ID: <m13bgs3tuz.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


How does this look for making that comment readable?

Eric


diff --git a/arch/i386/kernel/machine_kexec.c b/arch/i386/kernel/machine_kexec.c
index f73d737..7a344b6 100644
--- a/arch/i386/kernel/machine_kexec.c
+++ b/arch/i386/kernel/machine_kexec.c
@@ -189,14 +189,11 @@ NORET_TYPE void machine_kexec(struct kim
 	memcpy((void *)reboot_code_buffer, relocate_new_kernel,
 						relocate_new_kernel_size);
 
-	/* The segment registers are funny things, they are
-	 * automatically loaded from a table, in memory wherever you
-	 * set them to a specific selector, but this table is never
-	 * accessed again you set the segment to a different selector.
-	 *
-	 * The more common model is are caches where the behide
-	 * the scenes work is done, but is also dropped at arbitrary
-	 * times.
+	/* The segment registers are funny things, they have both a
+	 * visible and an invisible part.  Whenver the visible part is
+	 * set to a specific selector, the invisible part is loaded
+	 * with from a table in memory.  At no other time is the
+	 * descriptor table in memory accessed. 
 	 *
 	 * I take advantage of this here by force loading the
 	 * segments, before I zap the gdt with an invalid value.
