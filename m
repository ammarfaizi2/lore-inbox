Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751006AbWITKWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbWITKWK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 06:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbWITKWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 06:22:09 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37251 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751005AbWITKWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 06:22:08 -0400
Subject: Re: [PATCH] Linux Kernel Markers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: karim@opersys.com
Cc: Mathieu Desnoyers <compudj@krystal.dyndns.org>,
       Martin Bligh <mbligh@google.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, "Frank Ch. Eigler" <fche@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com
In-Reply-To: <451090E7.603@opersys.com>
References: <20060918234502.GA197@Krystal> <20060919081124.GA30394@elte.hu>
	 <451008AC.6030006@google.com> <20060919154612.GU3951@redhat.com>
	 <4510151B.5070304@google.com> <20060919093935.4ddcefc3.akpm@osdl.org>
	 <45101DBA.7000901@google.com> <20060919063821.GB23836@in.ibm.com>
	 <45102641.7000101@google.com>  <20060919175405.GC26339@Krystal>
	 <1158710925.32598.120.camel@localhost.localdomain>
	 <451090E7.603@opersys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 20 Sep 2006 11:44:29 +0100
Message-Id: <1158749069.7705.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-09-19 am 20:52 -0400, ysgrifennodd Karim Yaghmour:
> a) the errata & a possible thread having an IP leading back within (not
>    at the start of) the range to be replaced.
> b) the errata & replacing single instruction with single instruction of
>    same size.

Intel don't distinguish. Richard's reply later in the thread answers a
lot more including what Intels architecture team said about int3 being a
specific safe case for soem reason

> I was vaguely aware of the issue on x86. Do you know if this applies the
> same on other achitectures?

I wouldn't know. 

> Also, this is SMP-only, right? (Not that single UP matters for desktop
> anymore, but just checking.)

There are some uniprocessor errata but I cannot see how you could patch
code, somehow take an interrupt (or return from one) without executing a
serializing instruction, so I likewise think its SMP only.

> Any pointers to the errata?

developer.intel.com 'specification update' documents (which are always
good reading).
