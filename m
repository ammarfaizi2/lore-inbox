Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbVF1TaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVF1TaF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 15:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVF1T1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 15:27:54 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.83]:39553 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S261163AbVF1T1f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 15:27:35 -0400
From: Jeremy Maitin-Shepard <jbms@cmu.edu>
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Read only syscall tables for x86_64 and i386
References: <Pine.LNX.4.62.0506281141050.959@graphe.net>
	<87oe9q70no.fsf@jbms.ath.cx> <Pine.LNX.4.62.0506281218030.1454@graphe.net>
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-1: winter into spring
Date: Tue, 28 Jun 2005 15:27:30 -0400
In-Reply-To: <Pine.LNX.4.62.0506281218030.1454@graphe.net> (Christoph
	Lameter's message of "Tue, 28 Jun 2005 12:18:29 -0700 (PDT)")
Message-ID: <87hdfi704d.fsf@jbms.ath.cx>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <christoph@lameter.com> writes:

> On Tue, 28 Jun 2005, Jeremy Maitin-Shepard wrote:
>> As I mentioned previously when this patch was first posted to the list,
>> AFS writes to the syscall table.  It does this even for Linux 2.6.
>> Apparently, the rodata section is not actually mapped read-only, so this
>> patch will probably not break AFS; nonetheless, it seems it would still
>> be better to keep the syscall table in a section that is supposed to be
>> writable.

> Maybe this needs to be fixed?

It would probably be better implemented with a more generic mechanism,
but I don't believe anyone is working on that now, so it looks like AFS
will continue to use a special syscall.

-- 
Jeremy Maitin-Shepard
