Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262738AbTKIR4o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 12:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbTKIR4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 12:56:43 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:1030
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S262738AbTKIR4m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 12:56:42 -0500
Subject: Re: preemption when running in the kernel
From: Robert Love <rml@tech9.net>
To: Frank Cusack <fcusack@fcusack.com>
Cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20031109020424.A801@google.com>
References: <20031107040427.A32421@google.com>
	 <200311081402.07345.ioe-lkml@rameria.de>
	 <1068337385.27320.203.camel@localhost>  <20031109020424.A801@google.com>
Content-Type: text/plain
Message-Id: <1068400600.27320.1273.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sun, 09 Nov 2003 12:56:40 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-11-09 at 05:04, Frank Cusack wrote:

> Thank you for the clarification.

No problem.

> That leads me to 2 followup questions.
> 
> If a task in the kernel is preempted, is a membar issued?  (I believe
> so -- running another task means that the scheduler must have run,
> which will grab and release various locks thus giving us the membars.)

Yes, a memory barrier is definitely issued.

> When the preempted task resumes, is it guaranteed to run on the same CPU?
> (I wouldn't expect so, unless the task was specifically told to do that
> via hard affinity.  But maybe a task preempted in the kernel is different
> then a task preempted in userland.)

No.  A preempted task can reschedule on any processor.

	Robert Love


