Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266896AbUJWKpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266896AbUJWKpl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 06:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267283AbUJWKlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 06:41:53 -0400
Received: from mx1.elte.hu ([157.181.1.137]:29069 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266896AbUJWKlJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 06:41:09 -0400
Date: Sat, 23 Oct 2004 12:40:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Chris Wright <chrisw@osdl.org>
Cc: akpm@osdl.org, torvalds@osdl.org, Andrea Arcangeli <andrea@novell.com>,
       johansen@immunix.com, Stephen Smalley <sds@epoch.ncsc.mil>,
       Thomas Bleher <bleher@informatik.uni-muenchen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] delay rq_lock acquisition in setscheduler
Message-ID: <20041023104026.GA31448@elte.hu>
References: <20041022125950.X2357@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022125950.X2357@build.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Chris Wright <chrisw@osdl.org> wrote:

> Doing access control checks with rq_lock held can cause deadlock when
> audit messages are created (via printk or audit infrastructure) which
> trigger a wakeup and deadlock, as noted by both SELinux and SubDomain
> folks.  This patch will let the security checks happen w/out lock held,
> then re-sample the p->policy in case it was raced.  Originally from John
> Johansen <johansen@immunix.com>, reworked by me.  AFAIK, this version
> drew no objections from Ingo or Andrea.  Please let me know if there's
> any issue with the patch.
> 
> From: John Johansen <johansen@immunix.com>
> Signed-off-by: Chris Wright <chrisw@osdl.org>

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
