Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030336AbWFCVKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030336AbWFCVKY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 17:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030360AbWFCVKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 17:10:24 -0400
Received: from wx-out-0102.google.com ([66.249.82.200]:4501 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030336AbWFCVKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 17:10:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=EjqC5iVEUTB4EKD8ZgtyxdogLp9UrQ4NWV5ba34i1Vj+X8BHrT13PQdt7fabY0F+kHdtEv5z4NZdKckur7y5dSCmxqMHewiWboVQhCfDlbhuZitFovvmiKM2MzSF3aWTLWtvGl3RDoknEODrirt10cg4bsPmNrUJXlZyHnCXZNs=
Message-ID: <986ed62e0606031410h48efd8b7i3a89e1c7ba1cd778@mail.gmail.com>
Date: Sat, 3 Jun 2006 14:10:22 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.17-rc5-mm2
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Arjan van de Ven" <arjan@infradead.org>
In-Reply-To: <20060603144121.GA3701@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060601014806.e86b3cc0.akpm@osdl.org>
	 <986ed62e0606011758w348080ebn6e8430ec9e5b2ed3@mail.gmail.com>
	 <20060601183836.d318950e.akpm@osdl.org>
	 <986ed62e0606020614j363bd71bn7d1fba23b78571f3@mail.gmail.com>
	 <20060602142009.GA10236@elte.hu>
	 <986ed62e0606021101t6701d095ycd29c91885aaeec9@mail.gmail.com>
	 <20060602205332.GA5022@elte.hu>
	 <986ed62e0606021533n4c8954eeifd71f97611a4c7f@mail.gmail.com>
	 <20060603071301.GB19257@elte.hu> <20060603144121.GA3701@elte.hu>
X-Google-Sender-Auth: ee6e5698ad54698d
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Ingo Molnar <mingo@elte.hu> wrote:
>
> > just disable FORCED_INLINING in the .config, turn on EMBEDDED and
> > select OPTIMIZE_FOR_SIZE, and that should give you 30-40% of kernel
> > size savings.

I was already doing OPTIMIZE_FOR_SIZE. I didn't think of disabling
FORCED_INLINING, thanks for reminding me of that. I managed to trim
the kernel in other ways.

> also, the latest combo patch:
>
>   http://redhat.com/~mingo/lockdep-patches/lockdep-combo-2.6.17-rc5-mm2.patch
>
> should have the floppy bug(s) fixed.

I'll try that later today (and I'll also provide the
/proc/latency_trace to help figure out the warning). In the meantime,
I can confirm that the floppy drive started working again with
lock-validator-floppyc-irq-release-fix.patch reverted.

BTW, the latency_trace is close to 130K. Should I send it to you by
private mail instead of to the list? Or should I compress it and send
it as an attachment?

Andrew, I can also confirm that the LLC hotfix is allowing LLC (and
AppleTalk) to work again.
-- 
-Barry K. Nathan <barryn@pobox.com>
