Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267953AbTAHWvv>; Wed, 8 Jan 2003 17:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267954AbTAHWvv>; Wed, 8 Jan 2003 17:51:51 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:46088
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267953AbTAHWvu>; Wed, 8 Jan 2003 17:51:50 -0500
Subject: Re: [PATCH]: Remove PF_MEMDIE as it is redundant
From: Robert Love <rml@tech9.net>
To: Juan Quintela <quintela@mandrakesoft.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <m2r8bn6yxz.fsf@demo.mitica>
References: <m2r8bn6yxz.fsf@demo.mitica>
Content-Type: text/plain
Organization: 
Message-Id: <1042066824.694.3634.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-3) 
Date: 08 Jan 2003 18:00:24 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-01-08 at 17:47, Juan Quintela wrote:

>         PF_MEMDIE don't have any use in current kernels.  Please
>         remove, we only set it in one place, and there we also set
>         PF_MEMALLOC.  And we only test it in other place, and we also
>         test for PF_MEMALLOC.  This patch has existed in aa for some
>         quite time.

I independently thought this same thing, and did a patch for 2.5 which
had the same effect.

I was reminded by better-VM-hackers-than-I that PF_MEMALLOC can be
cleared in various paths so the PF_MEMDIE is required to ensure that the
check in page_alloc.c is always true for OOM'ed tasks.

	Robert Love

