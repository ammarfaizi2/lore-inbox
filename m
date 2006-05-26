Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbWEZWCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbWEZWCA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 18:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWEZWCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 18:02:00 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:60656 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751298AbWEZWB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 18:01:59 -0400
Message-ID: <44777AD2.5040502@gmail.com>
Date: Fri, 26 May 2006 23:01:54 +0100
From: Catalin Marinas <catalin.marinas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.17-rc4 1/6] Base support for kmemleak
References: <20060513155757.8848.11980.stgit@localhost.localdomain> <20060513160541.8848.2113.stgit@localhost.localdomain> <p73u07t5x6f.fsf@bragg.suse.de> <20060526085916.GA14388@elte.hu>
In-Reply-To: <20060526085916.GA14388@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> Also, kmemleak guarantees (assuming the implementation is correct) that 
> if a leak happens in practice, it will be detected immediately. 
> Coverity, being a static analyzer, wont find leaks that are obscured by 
> some sort of complex codepath.

A good example is the skb allocation/freeing. I'm not sure Coverity is
able to track the code path in a protocol stack. I'll modify a network
driver to "forget" some skb freeing and test the kmemleak detection.

Catalin
