Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbTJAFEc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 01:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbTJAFEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 01:04:32 -0400
Received: from dyn-ctb-203-221-73-105.webone.com.au ([203.221.73.105]:51461
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S261930AbTJAFEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 01:04:31 -0400
Message-ID: <3F7A604F.1060905@cyberone.com.au>
Date: Wed, 01 Oct 2003 15:04:15 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: "Murray J. Root" <murrayr@brain.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: 2.6.0-test6 scheduling(?) oddness
References: <20031001032238.GB1416@Master> <20030930215512.1df59be3.akpm@osdl.org>
In-Reply-To: <20030930215512.1df59be3.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>"Murray J. Root" <murrayr@brain.org> wrote:
>
>>The render finishes in the same 30 minutes, then oowriter starts.
>> oowriter takes about 3 seconds to load if no rendering is going on.
>>
>
>OpenOffice uses sched_yield() in strange ways which causes it to
>get hopelessly starved on 2.6 kernels.  I think RH have a fixed version,
>but I don't know if that has propagated into the upstream yet.
>
>

OK. Aside from the OpenOffice issue, you still have povray taking 50%
longer to complete, which is quite remarkable if its single threaded and
nothing else is running. Maybe its not the scheduler change? Anyway,
Con will want to know exactly which version of his scheduler you used in
test5 to check for possibilities.


