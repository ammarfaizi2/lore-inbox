Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbVHWOme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbVHWOme (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 10:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbVHWOme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 10:42:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52418 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932107AbVHWOme (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 10:42:34 -0400
Date: Tue, 23 Aug 2005 10:42:30 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Ingo Molnar <mingo@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Ulrich Drepper <drepper@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] FUTEX_WAKE_OP (pthread_cond_signal speedup)
Message-ID: <20050823144230.GB7403@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20050823131817.GA7403@devserv.devel.redhat.com> <Pine.LNX.4.58.0508231033270.18304@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508231033270.18304@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2005 at 10:36:08AM -0400, Ingo Molnar wrote:
> a detail: many of the futex_atomic_op_inuser() seem to be duplicated
> across architectures. Might be worth putting into asm-generic, to avoid
> the duplication?

Those are stub files waiting for arch maintainers to actually implement
them, so they will be eventually different, but for the time being they
just -ENOSYS, so that things compile.

	Jakub
