Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTLHTqq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 14:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbTLHTqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 14:46:46 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:45463 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261825AbTLHTqo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 14:46:44 -0500
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM LTC
To: Nick Piggin <piggin@cyberone.com.au>, Ingo Molnar <mingo@redhat.com>,
       Anton Blanchard <anton@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Zwane Mwaikambo <zwane@zwane.ca>
Subject: Re: [PATCH][RFC] make cpu_sibling_map a cpumask_t
Date: Mon, 8 Dec 2003 11:44:57 -0800
User-Agent: KMail/1.5
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <3FD3FD52.7020001@cyberone.com.au>
In-Reply-To: <3FD3FD52.7020001@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312081144.57157.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 07 December 2003 8:25 pm, Nick Piggin wrote:
> Hi guys,
> This is rather a trivial change but is not for 2.6.0.
> The patch is actually on top of some of my HT stuff so one part is
> slightly different, but its purpose is to gather feedback.
>
> It turns the cpu_sibling_map array from an array of cpus to an array
> of cpumasks. This allows handling of more than 2 siblings, not that
> I know of any immediate need.

There will probably be a need, although I don't know how soon.  Some of the 
Intel folks have not been hinting that there will be more than two siblings 
in a future CPU.  No, they have not been hinting at all.   ;^)


> I think it generalises cpu_sibling_map sufficiently that it can become
> generic code. This would allow architecture specific code to build the
> sibling map, and then Ingo's or my HT implementations to build their
> scheduling descriptions in generic code.
>
> I'm not aware of any reason why the kernel should not become generally
> SMT aware. It is sufficiently different to SMP that it is worth
> specialising it, although I am only aware of P4 and POWER5 implementations.
>
> Best regards
> Nick
>
> P.S.
> I have an alternative to Ingo's HT scheduler which basically does
> the same thing. It is showing a 20% elapsed time improvement with a
> make -j3 on a 2xP4 Xeon (4 logical CPUs).
>
> Before Ingo's is merged, I would like to discuss the pros and cons of
> both approaches with those interested. If Ingo's is accepted I should
> still be able to port my other SMP/NUMA improvements on top of it.

-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot comm
