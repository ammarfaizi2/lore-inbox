Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbWISQST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWISQST (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 12:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbWISQST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 12:18:19 -0400
Received: from smtp-out.google.com ([216.239.33.17]:21918 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750905AbWISQSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 12:18:18 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=VQIeBqvBILvkHP51WcUKltB0q3A+9d2eBBvkQSFTODsf87vLo8iRwC0mD4q44sNZ5
	rhalZodVx9O8P8oDzB67g==
Message-ID: <45101809.5030906@google.com>
Date: Tue, 19 Sep 2006 09:17:13 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: karim@opersys.com
CC: Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       "Frank Ch. Eigler" <fche@redhat.com>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers
References: <20060918234502.GA197@Krystal> <20060919081124.GA30394@elte.hu> <451008AC.6030006@google.com> <45101965.3050509@opersys.com>
In-Reply-To: <45101965.3050509@opersys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour wrote:
> Martin J. Bligh wrote:
> 
>>Why don't we just copy the whole damned function somewhere else, and
>>make an instrumented copy (as a kernel module)?
> 
> 
> If you're going to go with that, then why not just use a comment-based
> markup? 

Comment, marker macro, flat patch, don't care much. all would work.

> Then your alternate copy gets to be generated from the same codebase.

That was always the intent, or codebase + flat patch if really 
necessary. Sorry if that wasn't clear.

> It also solves the inherent problem of decided on whether
> a macro-based markup is far too intrusive, since you can mildly allow
> yourself more verbosity in a comment. Not only that, but if it's
> comment-based, it's even forseable, though maybe not desirable, than
> *everything* that deals with this type of markup be maintained out
> of tree (i.e. scripts generating alternate functions and all.)

Not sure we need scripts, just a normal patch diff would do. I'm not
sure any of this alters the markup debate much ... it just would seem
to provide a simpler, faster, and more flexible way of hooking in than
kprobes.

M.
