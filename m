Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWEPPVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWEPPVm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 11:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWEPPVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 11:21:42 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:20682
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932084AbWEPPVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 11:21:41 -0400
Message-Id: <446A0A57.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Tue, 16 May 2006 17:22:31 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: "Andrew Morton" <akpm@osdl.org>, "Andreas Kleen" <ak@suse.de>,
       <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: Re: [PATCH 1/3] reliable stack trace support
References: <4469FC07.76E4.0078.0@novell.com> <20060516143937.GA10760@elte.hu>
In-Reply-To: <20060516143937.GA10760@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Ingo Molnar <mingo@elte.hu> 16.05.06 16:39 >>>
>> +config STACK_UNWIND
>> +	bool "Stack unwind support"
>> +	depends on UNWIND_INFO
>> +	depends on n
>
>'depends on n' ? Also, i think this should be 'default y'. The code is 

Subsequent patches then change it to X86_64 and then X86. This is just so the patch can be used standalone.

>very clean. Curious: how much testing has it seen?

The code, in slightly different shape, has been in use in NLKD (and its non-Linux ancestor) for several years. The only
new code is the hook-up for the stack trace display functions, where I tried to make sure I test all (known to me)
possibilities.

Jan
