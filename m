Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264610AbSKDBL5>; Sun, 3 Nov 2002 20:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264611AbSKDBL5>; Sun, 3 Nov 2002 20:11:57 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:45324
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S264610AbSKDBL4>; Sun, 3 Nov 2002 20:11:56 -0500
Subject: Re: interrupt checks for spinlocks
From: Robert Love <rml@tech9.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20021104005339.GA16347@holomorphy.com>
References: <mailman.1036362421.16883.linux-kernel2news@redhat.com>
	<200211040028.gA40S8600593@devserv.devel.redhat.com>
	<20021104002813.GZ16347@holomorphy.com>
	<20021103194249.A1603@devserv.devel.redhat.com> 
	<20021104005339.GA16347@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Nov 2002 20:18:04 -0500
Message-Id: <1036372685.752.7.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-11-03 at 19:53, William Lee Irwin III wrote:

> This non-reentrant stuff hurts my head. Another patch down the
> toilet, I guess.

No, I think you have a good idea.  Pete is right, though, the current
interrupt is disabled... but normally the other interrupts are still
enabled.

Your ideas #2, #3, and #4 are good.

Because once the lock is tainted, you still want to ensure process
context disables interrupts before grabbing the lock.

	Robert Love

