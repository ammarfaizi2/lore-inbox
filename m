Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262445AbVDGOzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262445AbVDGOzH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 10:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262460AbVDGOzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 10:55:07 -0400
Received: from mx1.elte.hu ([157.181.1.137]:51675 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262445AbVDGOyc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 10:54:32 -0400
Date: Thu, 7 Apr 2005 16:54:12 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Keith Owens <kaos@sgi.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-rc2 in_atomic() picks up preempt_disable()
Message-ID: <20050407145412.GA6520@elte.hu>
References: <13730.1112868613@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13730.1112868613@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Keith Owens <kaos@sgi.com> wrote:

> 2.6.12-rc2, with CONFIG_PREEMPT and CONFIG_PREEMPT_DEBUG.  The 
> in_atomic() macro thinks that preempt_disable() indicates an atomic 
> region so calls to __might_sleep() result in a stack trace. 
> preempt_count() returns 1, no soft or hard irqs are running and no 
> spinlocks are held.  It looks like there is no way to distinguish 
> between the use of preempt_disable() in the lock functions (atomic) 
> and preempt_disable() outside the lock functions (do nothing that 
> might migrate me).

preempt_disable() sections are just as much atomic as spinlocked 
regions. Like the name suggests it.

	Ingo
