Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264592AbUE0Ouj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264592AbUE0Ouj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 10:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264596AbUE0Ouj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 10:50:39 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:16265
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264592AbUE0Ouh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 10:50:37 -0400
Date: Thu, 27 May 2004 16:50:33 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Ingo Molnar <mingo@elte.hu>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Arjan van de Ven <arjanv@redhat.com>, Rik van Riel <riel@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 4k stacks in 2.6
Message-ID: <20040527145033.GF3889@dualathlon.random>
References: <20040525211522.GF29378@dualathlon.random> <20040526103303.GA7008@elte.hu> <20040526125014.GE12142@wohnheim.fh-wedel.de> <20040526125300.GA18028@devserv.devel.redhat.com> <20040526130047.GF12142@wohnheim.fh-wedel.de> <20040526130500.GB18028@devserv.devel.redhat.com> <20040526164129.GA31758@wohnheim.fh-wedel.de> <20040527124551.GA12194@elte.hu> <20040527135930.GC3889@dualathlon.random> <40B5F8C0.2010005@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B5F8C0.2010005@didntduck.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2004 at 10:18:40AM -0400, Brian Gerst wrote:
> The problem on i386 (unlike x86-64) is that the thread_info struct sits 
> at the bottom of the stack and is referenced by masking bits off %esp. 
> So the stack size must be constant whether in process context or IRQ 
> context.

so what, that's a minor implementation detail, pda is a software thing.
