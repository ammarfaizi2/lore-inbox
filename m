Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964948AbWGEUZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbWGEUZP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 16:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964989AbWGEUZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 16:25:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59527 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964948AbWGEUZO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 16:25:14 -0400
Date: Wed, 5 Jul 2006 13:24:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] i386: early pagefault handler
In-Reply-To: <200607050745_MC3-1-C42B-9937@compuserve.com>
Message-ID: <Pine.LNX.4.64.0607051319090.12404@g5.osdl.org>
References: <200607050745_MC3-1-C42B-9937@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 5 Jul 2006, Chuck Ebbert wrote:
>
> Page faults during kernel initialization can be hard to diagnose.
> 
> Add a handler that prints the fault address, EIP and top of stack
> when an early page fault happens.

Is there really any reason to do this in assembler? The "start_kernel" 
call into C happens not that much later, and none of what the routine does 
seems to really be especially assembler-friendly. 

			Linus
