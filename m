Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263221AbTLADxn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 22:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263258AbTLADxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 22:53:43 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:24070
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S263221AbTLADxm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 22:53:42 -0500
Subject: Re: question about preempt_disable()
From: Rob Love <rml@tech9.net>
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <pan.2003.11.30.17.39.47.71027@smurf.noris.de>
References: <000d01c3b6dd$30ab34a0$8a04a943@bananacabana>
	 <pan.2003.11.30.17.39.47.71027@smurf.noris.de>
Content-Type: text/plain
Message-Id: <1070250821.1158.45.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Sun, 30 Nov 2003 22:53:41 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-11-30 at 12:39, Matthias Urlichs wrote:

> You need to prevent deadlocks. Imagine process A grabbing a spinlock, then
> getting preempted. Process B now sits there and waits on the spinlock.
> Forward progress may or may not happen when the scheduler preempts B and
> restarts A, some indeterminate time later.

Further, on uniprocessor systems, we don't have deadlocks so it is the
preempt_disable() that actually ensures concurrency is prevented in the
critical region.

	Rob Love


