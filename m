Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbVF1TpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVF1TpO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 15:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVF1TnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 15:43:01 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.83]:50051 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S261232AbVF1TmK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 15:42:10 -0400
From: Jeremy Maitin-Shepard <jbms@cmu.edu>
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Read only syscall tables for x86_64 and i386
References: <Pine.LNX.4.62.0506281141050.959@graphe.net>
	<87oe9q70no.fsf@jbms.ath.cx> <Pine.LNX.4.62.0506281218030.1454@graphe.net>
	<87hdfi704d.fsf@jbms.ath.cx> <Pine.LNX.4.62.0506281230550.1630@graphe.net>
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-1: winter into spring
Date: Tue, 28 Jun 2005 15:41:56 -0400
In-Reply-To: <Pine.LNX.4.62.0506281230550.1630@graphe.net> (Christoph
	Lameter's message of "Tue, 28 Jun 2005 12:31:33 -0700 (PDT)")
Message-ID: <87br5q6zgb.fsf@jbms.ath.cx>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <christoph@lameter.com> writes:

> On Tue, 28 Jun 2005, Jeremy Maitin-Shepard wrote:
>> It would probably be better implemented with a more generic mechanism,
>> but I don't believe anyone is working on that now, so it looks like AFS
>> will continue to use a special syscall.

> We could put an #ifdef CONFIG_AFS into the syscall table definition?
> That makes it explicit.

I haven't looked much at the AFS support in the mainline kernel,
but I believe it is read-only support, and doesn't support
authentication.  It may well have no need for a system call.

I was actually referring to the OpenAFS implementation, which is built
separately from the kernel as a module; thus, the #ifdef CONFIG_AFS
would not work.  An additional configuration option could be added, but
I'm not sure that is a good idea.

-- 
Jeremy Maitin-Shepard
