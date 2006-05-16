Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751632AbWEPQGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbWEPQGB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 12:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbWEPQGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 12:06:01 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:63954
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751632AbWEPQGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 12:06:00 -0400
Message-Id: <446A14B7.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Tue, 16 May 2006 18:06:47 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: Re: [PATCH 2/3] reliable stack trace support (x86-64)
References: <4469FC22.76E4.0078.0@novell.com> <200605161713.39575.ak@suse.de>
In-Reply-To: <200605161713.39575.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Andi Kleen <ak@suse.de> 16.05.06 17:13 >>>
On Tuesday 16 May 2006 16:21, Jan Beulich wrote:
>> These are the x86_64-specific pieces to enable reliable stack traces. The
>> only restriction with this is that it currently cannot unwind across the
>> interrupt->normal stack boundary, as that transition is lacking proper
>> annotation.
>
>It would be nice if you could submit a patch to fix that.

But I don't know how to fix it. See my other mail - I have no experience with expressions, nor have I ever seen them in
use.

>> +#define UNW_PC(frame) (frame)->regs.rip
>> +#define UNW_SP(frame) (frame)->regs.rsp
>
>I think we alreay have instruction_pointer(). Better add a stack_pointer() 
>in ptrace.h too.

I could do that, but the macros will have to remain, as they don't access pt_regs directly, so I guess it'd be
pointless to change it.

Jan
