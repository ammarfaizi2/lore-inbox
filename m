Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbVJKDpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbVJKDpc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 23:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbVJKDpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 23:45:32 -0400
Received: from xproxy.gmail.com ([66.249.82.202]:2754 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750906AbVJKDpb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 23:45:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HR6phmDN2Q2QJ4OMBTtsY4S7LgzGSAEuNvqmpYw12NzqNVWiZ3I3f6Y1iIvpTFPw6AZL+l/4SMm+0ZgTixKlfrqfCQ3EFjVX8GJfhUvMoK/FiHCr4ZVqmNX7Mp0b1O1TQiVMnVhiSEudEXRkl2UntQQ1Di0iA8arpsqg6n8QX7E=
Message-ID: <5bdc1c8b0510102045u7e4bc9eeld5b690b5e96c4a5f@mail.gmail.com>
Date: Mon, 10 Oct 2005 20:45:30 -0700
From: Mark Knecht <markknecht@gmail.com>
To: Daniel Walker <dwalker@mvista.com>
Subject: Re: Latency data - 2.6.14-rc3-rt13
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Lee Revell <rlrevell@joe-job.com>
In-Reply-To: <5bdc1c8b0510101649s221ab437scc49d6a49269d6b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b0510101316k23ff64e2i231cdea7f11e8553@mail.gmail.com>
	 <1128977359.18782.199.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <5bdc1c8b0510101412n714c4798v1482254f6f8e0386@mail.gmail.com>
	 <5bdc1c8b0510101428o475d9dbct2e9bdcc6b46418c9@mail.gmail.com>
	 <1128980674.18782.211.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <5bdc1c8b0510101509w4c74028apb6e69746b1b8b65b@mail.gmail.com>
	 <1128983301.18782.215.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <5bdc1c8b0510101633lc45fbf8gd2677e5646dc6f93@mail.gmail.com>
	 <5bdc1c8b0510101649s221ab437scc49d6a49269d6b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/05, Mark Knecht <markknecht@gmail.com> wrote:
>
> ( softirq-timer/0-3    |#0): new 3997 us maximum-latency critical section.

So the root cause of this 4mS delay is the 250Hz timer. If I change
the system to use the 1Khz timer then the time in this section drops,
as expected, to 1mS.

( softirq-timer/0-3    |#0): new 998 us maximum-latency critical section.
 => started at timestamp 121040020: <acpi_processor_idle+0x20/0x379>
 =>   ended at timestamp 121041019: <thread_return+0xb5/0x11a>

So, thinking very interesting here I think.

Back to the drawing board as to my xruns.

- Mark
