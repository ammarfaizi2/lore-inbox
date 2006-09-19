Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030256AbWISQyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbWISQyU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 12:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751872AbWISQyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 12:54:19 -0400
Received: from smtp-out.google.com ([216.239.33.17]:42156 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750985AbWISQyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 12:54:19 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=OGM6OmK0FjjcrvNtJ8/NPWCx6Wf7P51XQejTUZ7h9g5CNMKamvB/VePQBqe1mciTj
	sf+SXfvhuUMl8Vp6rr/Bg==
Message-ID: <45102067.20601@google.com>
Date: Tue, 19 Sep 2006 09:52:55 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Frank Ch. Eigler" <fche@redhat.com>
CC: Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Paul Mundt <lethal@linux-sh.org>,
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
References: <20060918234502.GA197@Krystal> <20060919081124.GA30394@elte.hu>	<451008AC.6030006@google.com> <20060919154612.GU3951@redhat.com>	<4510151B.5070304@google.com> <y0m8xkfer8v.fsf@ton.toronto.redhat.com>
In-Reply-To: <y0m8xkfer8v.fsf@ton.toronto.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Ch. Eigler wrote:
> Martin Bligh <mbligh@google.com> writes:
> 
> 
>>[...]  "compiled anew from original sources after deployment" seems
>>the most practical to do to me.  From second hand info on using
>>systemtap, you seem to need the same compiler and source tree to
>>work from anyway [...]
> 
> 
> Not quite.  Systemtap does not look at sources, only object code and
> its embedded debugging information.  (How many distributions keep
> around compilable source trees?)

???? Boggle. Any distro that cannot find the source code for it's kernel
deserves a swift kick to the head, plus a red hot poker somewhere else.

>>[...] It seems like all we'd need to do is "list all references to
>>function, freeze kernel, update all references, continue", [...]
> 
> One additional problem are external references made *by* the function.
> Those too would all have to be relocated to the live data.

Not sure what you mean ... could you give a quick example?

> Live code patching is theoretically useful for all kinds of things,
> but I've never heard it described as relatively simple before! :-)

well, on a whole-function basis, it seems somewhat simpler.

M.
