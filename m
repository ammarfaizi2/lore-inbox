Return-Path: <linux-kernel-owner+w=401wt.eu-S932669AbXARWer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932669AbXARWer (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 17:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932666AbXARWer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 17:34:47 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:40675 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932663AbXARWeq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 17:34:46 -0500
Date: Thu, 18 Jan 2007 22:34:42 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@infradead.org>,
       Pierre Peiffer <pierre.peiffer@bull.net>,
       LKML <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>, Jakub Jelinek <jakub@redhat.com>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>
Subject: Re: [PATCH 2.6.20-rc5 4/4] sys_futex64 : allows 64bit futexes
Message-ID: <20070118223442.GB5404@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>,
	Pierre Peiffer <pierre.peiffer@bull.net>,
	LKML <linux-kernel@vger.kernel.org>,
	Ulrich Drepper <drepper@redhat.com>,
	Jakub Jelinek <jakub@redhat.com>,
	Jean-Pierre Dion <jean-pierre.dion@bull.net>
References: <45ADDF60.5080704@bull.net> <45ADE6B5.8050402@bull.net> <20070118001758.GB17257@infradead.org> <20070118074556.GB29128@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070118074556.GB29128@elte.hu>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2007 at 08:45:56AM +0100, Ingo Molnar wrote:
> include/asm-i386/futex.h:
> 
>                 switch (cmp) {
>                 case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
>                 case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
>                 case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
>                 case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
>                 case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
>                 case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
>                 default: ret = -ENOSYS;
>                 }
> 
> Pierre correctly matched the existing style.

Old code doing things wrong is no excuse for new code doing the same
mistake.  Much better send a patch to fix up the previous unreadable
mess aswell.  Then again some indentation fixups won't help that much
to make futrsx not the totally unreadable spaghetti code it's now ;-)
