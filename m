Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbTKIAXG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 19:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbTKIAXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 19:23:05 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:19212
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S261752AbTKIAXD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 19:23:03 -0500
Subject: Re: preemption when running in the kernel
From: Robert Love <rml@tech9.net>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: Frank Cusack <fcusack@fcusack.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200311081402.07345.ioe-lkml@rameria.de>
References: <20031107040427.A32421@google.com>
	 <200311081402.07345.ioe-lkml@rameria.de>
Content-Type: text/plain
Message-Id: <1068337385.27320.203.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 08 Nov 2003 19:23:05 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-11-08 at 08:01, Ingo Oeser wrote:

> While having preemption disabled or while actually holding a spinlock,
> preemption is disabled.
> 
> Disabling preemption is modifying a count, which must reach 0 again to
> have preemption enabled and trigger an reschedule, if needed.
> 
> Think of it roughly as a "counter of reasons to not preempt". If there
> are no reasons anymore, then we preempt.

Hi, Ingo.

This is an accurate description of 2.6, but Frank said for 2.4.

So, Frank, this is correct for 2.6 or 2.4 with the preempt-kernel patch,
but not a stock 2.4 kernel.  A stock 2.4 kernel will never preempt a
task running inside the kernel.

	Robert Love


