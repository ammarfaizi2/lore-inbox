Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269321AbUJKW5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269321AbUJKW5l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 18:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269320AbUJKW5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 18:57:41 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:32184 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269321AbUJKW5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 18:57:39 -0400
Message-ID: <416B0FD7.2000006@yahoo.com.au>
Date: Tue, 12 Oct 2004 08:57:27 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4-mm1
References: <20041011032502.299dc88d.akpm@osdl.org>	<416A70AA.3040608@yahoo.com.au> <20041011121331.58bd9c0a.akpm@osdl.org>
In-Reply-To: <20041011121331.58bd9c0a.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>>+no-wild-kswapd-2.patch
>>
>>Is this an improvement?
> 
> 
> Seems to be a wash in my testing.
> 
> 
>>It again decouples the "priority" semantics of
>>the direct and asynch reclaim paths.
> 
> 
> What's that mean?
> 

Before those patches, priority means what fraction of the lists
have to be scanned to free 32 pages.

Afterwards, it means something significantly different for
balance_pgdat.
