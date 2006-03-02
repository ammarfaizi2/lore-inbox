Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932528AbWCBUkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbWCBUkc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 15:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540AbWCBUkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 15:40:31 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:29657 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932500AbWCBUka (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 15:40:30 -0500
Message-ID: <4407577F.951E50BC@tv-sign.ru>
Date: Thu, 02 Mar 2006 23:37:19 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/23] tref: Implement task references.
References: <m1oe0yhy1w.fsf@ebiederm.dsl.xmission.com>
			<m1k6bmhxze.fsf@ebiederm.dsl.xmission.com> <m1mzgidnr0.fsf@ebiederm.dsl.xmission.com> <44074479.15D306EB@tv-sign.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:
> 
>         void put_pid_ref(struct pid_ref *ref)
>         {
>                 if (!ref || !atomic_dec_and_test(&ref->count))
>                         return;
> 
>                 write_lock_irq(&tasklist_lock);
>                 if (!atomic_read(&ref->count)) {

Ok, this is racy, but the fix is possible.

Oleg.
