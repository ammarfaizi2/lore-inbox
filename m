Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbUKBMbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbUKBMbA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 07:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbUKBMbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 07:31:00 -0500
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:32908 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261210AbUKBMaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 07:30:52 -0500
Message-ID: <41877DF5.8070008@yahoo.com.au>
Date: Tue, 02 Nov 2004 23:30:45 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] remove interactive credit
References: <418707CD.1080903@kolivas.org>
In-Reply-To: <418707CD.1080903@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> remove interactive credit
> 
> 
> 
> ------------------------------------------------------------------------
> 
> Special casing tasks by interactive credit was helpful for preventing fully
> cpu bound tasks from easily rising to interactive status. 
> 
> However it did not select out tasks that had periods of being fully cpu bound
> and then sleeping while waiting on pipes, signals etc. This led to a more
> disproportionate share of cpu time.
> 
> Backing this out will no longer special case only fully cpu bound tasks, and
> prevents the variable behaviour that occurs at startup before tasks declare
> themseleves interactive or not, and speeds up application startup slightly
> under certain circumstances. It does cost in interactivity slightly as load
> rises but it is worth it for the fairness gains.
> 
> Signed-off-by: Con Kolivas <kernel@kolivas.org>
> 

I'm scared :(

I'm in favour of any attempts to simplify things... but will it be two
months or three before this spontaneously explodes for half our userbase?

Andrew's boss so he gets to decide >:)
