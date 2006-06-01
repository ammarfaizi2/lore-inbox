Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751025AbWFAOug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbWFAOug (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 10:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbWFAOug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 10:50:36 -0400
Received: from smtp-out.google.com ([216.239.45.12]:8869 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751017AbWFAOuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 10:50:35 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=rSblOa6uSPzD6oVOWxE3EOkWjUR3i48wqcVtjNlG/voKXoDQbsm9q2kC9emyHJ+6x
	rVLoIfVoB2/yU0MWuxQLQ==
Message-ID: <447EFE86.7020501@google.com>
Date: Thu, 01 Jun 2006 07:49:42 -0700
From: "Martin J. Bligh" <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Ingo Molnar <mingo@elte.hu>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       apw@shadowen.org
Subject: Re: 2.6.17-rc5-mm1
References: <20060531211530.GA2716@elte.hu> <447E0A49.4050105@mbligh.org> <20060531213340.GA3535@elte.hu> <447E0DEC.60203@mbligh.org> <20060531215315.GB4059@elte.hu> <447E11B5.7030203@mbligh.org> <20060531221242.GA5269@elte.hu> <447E16E6.7020804@google.com> <20060531223243.GC5269@elte.hu> <447E1A7B.2000200@google.com> <20060531225013.GA7125@elte.hu> <Pine.LNX.4.64.0606011222230.17704@scrub.home>
In-Reply-To: <Pine.LNX.4.64.0606011222230.17704@scrub.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This is nonsense.
> If you do this do it at least correctly, e.g. something like:
> 
> config DEBUG_RUNTIME_CHECKS
> 	bool "Enable runtime debug checks"
> 
> config DEBUG_RUNTIME_CHECKS_ALL
> 	bool "Enable all runtime debug checks"
> 	depends on DEBUG_RUNTIME_CHECKS
> 
> config DEBUG_KERNEL
> 	bool "Kernel debugging"
> 
> ...
> 
> config DEBUG_FOO
> 	bool "foo" if DEBUG_KERNEL
> 	default DEBUG_RUNTIME_CHECKS

That doesn't seem to cover what we talked about clearly at all ?
I suppose the _ALL stuff is meant to cover stuff with overhead,
but frankly, what Ingo did seemed much clearer to me.

M.
