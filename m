Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262024AbVFGWy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbVFGWy7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 18:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVFGWy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 18:54:58 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.82]:4323 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S262024AbVFGWy5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 18:54:57 -0400
From: Jeremy Maitin-Shepard <jbms@cmu.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Move some more structures into "mostly_readonly"
References: <Pine.LNX.4.62.0506071128220.22950@ScMPusgw>
	<20050607194123.GA16637@infradead.org>
	<Pine.LNX.4.62.0506071258450.2850@ScMPusgw>
	<1118177949.5497.44.camel@laptopd505.fenrus.org>
	<42A61227.9090402@didntduck.org>
	<Pine.LNX.4.62.0506071519470.19659@ScMPusgw>
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-1: winter into spring
Date: Tue, 07 Jun 2005 18:54:57 -0400
In-Reply-To: <Pine.LNX.4.62.0506071519470.19659@ScMPusgw>
	(christoph@scalex86.org's message of "Tue, 7 Jun 2005 15:23:01 -0700
	(PDT)")
Message-ID: <87hdg9eq0u.fsf@jbms.ath.cx>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

christoph <christoph@scalex86.org> writes:

> On Tue, 7 Jun 2005, Brian Gerst wrote:
>> It doesn't really matter.  .rodata isn't actually mapped read-only. Doing so
>> would break up the large pages used to map the kernel.

> In that case.... here is a patch that moves the table into rodata.

AFS writes to the system call table.  If as Brian says, .rodata isn't
actually mapped read-only, then users of AFS could use this syscall
table patch without problems, but it is nonetheless pointless and
misleading.

-- 
Jeremy Maitin-Shepard
