Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030242AbWISQmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030242AbWISQmU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 12:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030250AbWISQmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 12:42:19 -0400
Received: from smtp-out.google.com ([216.239.33.17]:47271 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030242AbWISQmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 12:42:17 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=PWx3WKfpir5ilcqDnqKFCJrx5LowKL3fJh+4Uo+7PuTzWV/LG9/0T5kYNVu0L1Xwq
	m9FUorxejH+fbvsmLDLNw==
Message-ID: <45101DBA.7000901@google.com>
Date: Tue, 19 Sep 2006 09:41:30 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Frank Ch. Eigler" <fche@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers
References: <20060918234502.GA197@Krystal>	<20060919081124.GA30394@elte.hu>	<451008AC.6030006@google.com>	<20060919154612.GU3951@redhat.com>	<4510151B.5070304@google.com> <20060919093935.4ddcefc3.akpm@osdl.org>
In-Reply-To: <20060919093935.4ddcefc3.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Tue, 19 Sep 2006 09:04:43 -0700
> Martin Bligh <mbligh@google.com> wrote:
> 
> 
>>It seems like all we'd need to do
>>is "list all references to function, freeze kernel, update all
>>references, continue"
> 
> 
> "overwrite first 5 bytes of old function with `jmp new_function'".

Yes, that's simple. but slower, as you have a double jump. Probably
a damned sight faster than int3 though.

M.
