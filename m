Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265275AbTLLPwV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 10:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265278AbTLLPwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 10:52:21 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:41111 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S265275AbTLLPwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 10:52:18 -0500
Date: Fri, 12 Dec 2003 15:44:01 +0000
From: Dave Jones <davej@redhat.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [DOCUMENTATION] Revised Unreliable Kernel Locking Guide
Message-ID: <20031212154401.GA10584@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@us.ibm.com>
References: <20031212052812.E80972C085@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031212052812.E80972C085@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 12, 2003 at 04:24:18PM +1100, Rusty Russell wrote:
 > OK, I've put the html version up for your reading pleasure: the diff
 > is quite extensive and hard to read.
 > 
 > http://www.kernel.org/pub/linux/kernel/people/rusty/kernel-locking/
 > 
 > Feedback welcome,

Hi Rusty,
 Might be worth mentioning in the Per-CPU data section that code doing
operations on CPU registers (MSRs and the like) needs to be protected
by an explicit preempt_disable() / preempt_enable() pair if it's doing
operations that it expects to run on a specific CPU.

For examples, see arch/i386/kernel/msr.c & cpuid.c

		Dave

