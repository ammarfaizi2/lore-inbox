Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbUKSTAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbUKSTAJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 14:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbUKSTAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 14:00:09 -0500
Received: from smtp8.wanadoo.fr ([193.252.22.23]:33406 "EHLO smtp8.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261534AbUKSTAE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 14:00:04 -0500
Message-ID: <419E42B3.8070901@wanadoo.fr>
Date: Fri, 19 Nov 2004 20:00:03 +0100
From: Eric Pouech <pouech-eric@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040115
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Roland McGrath <roland@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Mike Hearn <mh@codeweavers.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: ptrace single-stepping change breaks Wine
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
In-Reply-To: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath a écrit :
>>No, TIF_SINGLESTEP gets set even when the _user_ set TF. It is just a flag
>>saying that we should re-enable TF when we get back to user space.
>>
>>So TIF_SINGLESTEP in no way implies that TF was set by a debugger.
> 
> 
> Ok, whatever.  I'm not really sure its use for the single-step stuff in
> Davide Libenzi's changes doesn't change the expected behavior for the
> nondebugger case, but it's too early in the morning to think hard about that.
> 
> Your change hit only one spot of three in arch/i386/kernel/signal.c where
> PT_PTRACED is now tested and it should be a "is PTRACE_SINGLESTEP in effect?"
> test.  Also the same spots in native and 32-bit emul for x86-64.
> 
> 
> Thanks,
> Roland
> 
the first patch put in BK by Linus doesn't fix the problem. Any plan to fix the 
two other spots Roland mentionned ?
A+

