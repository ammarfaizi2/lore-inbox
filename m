Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbVJNDzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbVJNDzi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 23:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbVJNDzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 23:55:38 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:46229 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751148AbVJNDzh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 23:55:37 -0400
Date: Fri, 14 Oct 2005 05:56:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       david singleton <dsingleton@mvista.com>
Subject: Re: 2.6.14-rc4-rt1
Message-ID: <20051014035600.GA8481@elte.hu>
References: <20051011111454.GA15504@elte.hu> <1129064151.5324.6.camel@cmn3.stanford.edu> <20051012061455.GA16586@elte.hu> <20051012071037.GA19018@elte.hu> <1129242595.4623.14.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129242595.4623.14.camel@cmn3.stanford.edu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> I could not boot the up version of the kernel, it hangs early, I'll 
> try to see why (weird).

did you try the maxcpus=1 boot option? That will boot up using a single 
CPU only. The bug is very likely somewhere in the APIC timer handling 
code. How does /proc/interrupts look like - does the 'LOC' counter [this 
represents local APIC interrupts] behave irregularly?

	Ingo
