Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWCVNTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWCVNTl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 08:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWCVNTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 08:19:41 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:43413 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751170AbWCVNTl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 08:19:41 -0500
Date: Wed, 22 Mar 2006 14:16:46 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, akpm@osdl.org
Subject: Re: [PATCH] possible scheduler deadlock in 2.6.16
Message-ID: <20060322131646.GB11714@elte.hu>
References: <20060322104143.GC30422@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060322104143.GC30422@krispykreme>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Anton Blanchard <anton@samba.org> wrote:

> One way to solve this is to always take runqueues in cpu id order. To 
> do this we add a cpu variable to the runqueue and check it in the 
> double runqueue locking functions.
> 
> Thoughts?

it's fine with me - the overhead to double_rq_lock() is minimal, and 
it's not critical code either.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
