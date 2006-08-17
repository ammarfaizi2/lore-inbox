Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbWHQEDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWHQEDX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 00:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbWHQEDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 00:03:23 -0400
Received: from smtp-out.google.com ([216.239.45.12]:13144 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932243AbWHQEDW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 00:03:22 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=ekTPU9BkA108kNXe1bfOgjVFdAM3KU5+k7zcZ77QGoqrQVGbvDxx26pMU/tX6ycWs
	ECTARwvXEOL8SrWGYLdAw==
Message-ID: <44E3E964.8010602@google.com>
Date: Wed, 16 Aug 2006 20:58:28 -0700
From: Daniel Phillips <phillips@google.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Peter Zijlstra <a.p.zijlstra@chello.nl>,
       David Miller <davem@davemloft.net>, riel@redhat.com, tgraf@suug.ch,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, Mike Christie <michaelc@cs.wisc.edu>
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
References: <20060808211731.GR14627@postel.suug.ch>	<44DBED4C.6040604@redhat.com>	<44DFA225.1020508@google.com>	<20060813.165540.56347790.davem@davemloft.net>	<44DFD262.5060106@google.com>	<20060813185309.928472f9.akpm@osdl.org>	<1155530453.5696.98.camel@twins> <20060813215853.0ed0e973.akpm@osdl.org>
In-Reply-To: <20060813215853.0ed0e973.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
>>Testcase:
>>
>>Mount an NBD device as sole swap device and mmap > physical RAM, then
>>loop through touching pages only once.
> 
> Fix: don't try to swap over the network.  Yes, there may be some scenarios
> where people have no local storage, but it's reasonable to expect anyone
> who is using Linux as an "enterprise storage platform" to stick a local
> disk on the thing for swap.
> 
> That leaves MAP_SHARED, but mm-tracking-shared-dirty-pages.patch will fix
> that, will it not?

Hi Andrew,

What happened to the case where we just fill memory full of dirty file
pages backed by a remote disk?

Regards,

Daniel
