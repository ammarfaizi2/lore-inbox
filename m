Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbVF1T7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVF1T7m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 15:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVF1T7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 15:59:08 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.83]:61573 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S261179AbVF1T6M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 15:58:12 -0400
From: Jeremy Maitin-Shepard <jbms@cmu.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Read only syscall tables for x86_64 and i386
In-Reply-To: <20050628194215.GB32240@infradead.org> (Christoph Hellwig's
	message of "Tue, 28 Jun 2005 20:42:15 +0100")
Date: Tue, 28 Jun 2005 15:52:50 -0400
References: <Pine.LNX.4.62.0506281141050.959@graphe.net>
	<87oe9q70no.fsf@jbms.ath.cx> <Pine.LNX.4.62.0506281218030.1454@graphe.net>
	<87hdfi704d.fsf@jbms.ath.cx> <Pine.LNX.4.62.0506281230550.1630@graphe.net>
	<20050628194215.GB32240@infradead.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-1: winter into spring
Message-ID: <87vf3y2qzz.fsf@jbms.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Tue, Jun 28, 2005 at 12:31:33PM -0700, Christoph Lameter wrote:
>> On Tue, 28 Jun 2005, Jeremy Maitin-Shepard wrote:
>> 
>> > It would probably be better implemented with a more generic mechanism,
>> > but I don't believe anyone is working on that now, so it looks like AFS
>> > will continue to use a special syscall.
>> 
>> We could put an #ifdef CONFIG_AFS into the syscall table definition?
>> That makes it explicit.

> No.  AFS is utterly wrong, and the sooner we make it fail to work the
> better.

Heh, well that is nice, but breaking it will only mean that I and every
other AFS user will have to revert the patch that breaks it;
furthermore, many distributions that provide binary kernels will
probably also have to revert the patch because many of their users will
want to use AFS.

-- 
Jeremy Maitin-Shepard
