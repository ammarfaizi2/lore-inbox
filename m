Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263521AbTJQVFs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 17:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263522AbTJQVFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 17:05:48 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:37249
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263521AbTJQVFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 17:05:47 -0400
Date: Fri, 17 Oct 2003 17:05:18 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: brodigan@pdx.edu
cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: 2.6.0-test7-bk9: Call trace at startup. Sleep function
 called from invalid context.
In-Reply-To: <1066423116.3f90534c7a625@webmail.pdx.edu>
Message-ID: <Pine.LNX.4.53.0310171702530.2831@montezuma.fsmlabs.com>
References: <1066423116.3f90534c7a625@webmail.pdx.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Oct 2003 brodigan@pdx.edu wrote:

> 1. Get call traces from error at startup involving
>    "in_atomic():1, irqs_disabled():0" and "Debug: sleeping function
>    called from invalid context."

Known issue, we're really running single threaded during boot so this is 
perfectly safe in this context.

> 2. I receive two call traces at startup. They mention irq_disable().
>    I do have ISA disabled, since I lack an ISA motherboard. Thankfully
>    this error is non fatal, only annoying.

It's not actually ISA related, but referring to whether the processor is 
currently accepting interrupts.

Thanks
