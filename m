Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbWGEQjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbWGEQjY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 12:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWGEQjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 12:39:24 -0400
Received: from terminus.zytor.com ([192.83.249.54]:43708 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964807AbWGEQjY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 12:39:24 -0400
Message-ID: <44ABEB20.2010702@zytor.com>
Date: Wed, 05 Jul 2006 09:38:56 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Chuck Ebbert <76306.1226@compuserve.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] i386: early pagefault handler
References: <200607050745_MC3-1-C42B-9937@compuserve.com> <p73veqcp58s.fsf@verdi.suse.de>
In-Reply-To: <p73veqcp58s.fsf@verdi.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
>> +hlt_loop:
>> +	hlt
> 
> There are still supported i386 CPUs that don't support HLT and
> would recursively fault here.
> 

The HLT has been supported since 8086.  However, it was broken in some 
early 486s (not 386s); that's what the test in the kernel is for.

I don't remember what the failure mode was, though; didn't think it was 
recursive faulting.

	-hpa
