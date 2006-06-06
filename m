Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbWFFRgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbWFFRgm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 13:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWFFRgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 13:36:42 -0400
Received: from smtp-out.google.com ([216.239.45.12]:10797 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750834AbWFFRgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 13:36:42 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=gVuspNe3jRR6Z54fKrWq/6FfWKoNSuH7Fh/rquxa6oR44fZ4zA2IA/TEMp1uzbD/n
	Iq8HQpXoRLAXkRomcQk5A==
Message-ID: <4485BCC2.7040605@google.com>
Date: Tue, 06 Jun 2006 10:34:58 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Christoph Lameter <clameter@sgi.com>, Andrew Morton <akpm@osdl.org>,
       apw@shadowen.org, mbligh@mbligh.org, linux-kernel@vger.kernel.org,
       ak@suse.de, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: 2.6.17-rc5-mm1
References: <447DEF49.9070401@google.com> <20060531140652.054e2e45.akpm@osdl.org> <447E093B.7020107@mbligh.org> <20060531144310.7aa0e0ff.akpm@osdl.org> <447E104B.6040007@mbligh.org> <447F1702.3090405@shadowen.org> <44842C01.2050604@shadowen.org> <Pine.LNX.4.64.0606051137400.17951@schroedinger.engr.sgi.com> <44848DD2.7010506@shadowen.org> <Pine.LNX.4.64.0606051304360.18543@schroedinger.engr.sgi.com> <44848F45.1070205@shadowen.org> <44849075.5070802@google.com> <Pine.LNX.4.64.0606051325351.18717@schroedinger.engr.sgi.com> <Pine.LNX.4.64.0606051334010.18717@schroedinger.engr.sgi.com> <20060605135812.30138205.akpm@osdl.org> <Pine.LNX.4.64.0606060537460.6045@blonde.wat.veritas.com> <Pine.LNX.4.64.0606060923250.27550@schroedinger.engr.sgi.com> <Pine.LNX.4.64.0606061805380.28806@blonde.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.64.0606061805380.28806@blonde.wat.veritas.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>Not really (though the clarity and reassurance of the additional
>>>MAX_SWAPFILES test is good).  We went over it a year or two back,
>>>and the macro contortions do involve MAX_SWAPFILES_SHIFT: which
>>>up to and including 2.6.17 has enforced the MAX_SWAPFILES limit.
>>
>>It looks though as if the testers were able to define more than 32 swap 
>>devices. So there is the danger of overwriting the memory 
>>following the swap info if we do not fix this.
>>
>>Where are the macro contortions? No arch uses MAX_SWAPFILES_SHIFT for its 
>>definitions and the only other significant use is in swapops.h to 
>>determine the shift.
> 
> 
> I'll go mad if I try to work it out again: I was as worried as you
> when I discovered that test in sys_swapon a year or so ago, apparently
> without any check on MAX_SWAPFILES; and went moaning to Andrew.  But
> once I'd worked through swp_type, pte_to_swp_entry, swp_entry_to_pte,
> swp_entry, I did come to the conclusion that the MAX_SWAPFILES bound
> was actually safely built in there.

If it's that difficult to figure out, is that not reason enough to rip
it all out and replace it? ;-) Life seems quite complicated enough as
it is.

M.
