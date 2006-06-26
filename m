Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932999AbWFZUE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932999AbWFZUE6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 16:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932998AbWFZUE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 16:04:58 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:17375 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932987AbWFZUE5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 16:04:57 -0400
Date: Mon, 26 Jun 2006 21:59:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Brown, Len" <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       michal.k.k.piotrowski@gmail.com, arjan@linux.intel.com,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       "Moore, Robert" <robert.moore@intel.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch] ACPI: reduce code size, clean up, fix validator message
Message-ID: <20060626195958.GB15038@elte.hu>
References: <CFF307C98FEABE47A452B27C06B85BB6D8C286@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6D8C286@hdsmsx411.amr.corp.intel.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5001]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Brown, Len <len.brown@intel.com> wrote:

> Keep in perspective, however, that we have over 200 functional issues 
> unresolved in bugzilla.kernel.org, and spending time on syntax changes 
> is generally a lower priority.

well, it's your baby and they are your priorities (and i'm really not 
trying to interfere), but still - my personal experience is that syntax 
and functional correctness are strongly connected. I dont claim that 
this particular issue of lock initialization and abstraction is a big 
deal in itself, but cruft does add up over time and becomes a real 
obstacle. I usually spend alot of quality time cleaning up my own code, 
because i know that it directly results in a better ability to improve, 
extend or debug the code in the future. [ Then again, i dont write code 
for 9 platforms :-) ]

( for example the ACPI practice of allocating opaque 'handler' pointers 
  that carry no type at [they are void *] is playing with fire. It in 
  essence disables the remaining little bit of type-safety that C has. )

	Ingo
