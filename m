Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288991AbSAIT6F>; Wed, 9 Jan 2002 14:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288990AbSAIT5w>; Wed, 9 Jan 2002 14:57:52 -0500
Received: from quark.didntduck.org ([216.43.55.190]:32019 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S288987AbSAIT5I>; Wed, 9 Jan 2002 14:57:08 -0500
Message-ID: <3C3CA078.52242C57@didntduck.org>
Date: Wed, 09 Jan 2002 14:56:40 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Sipos Ferenc <sferi@dumballah.tvnet.hu>, linux-kernel@vger.kernel.org
Subject: Re: system time issue
In-Reply-To: <Pine.LNX.3.95.1020109143029.8141A-101000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> The code works by disabling paging while executing code where
> there is not a 1:1 physical/virtual page mapping. I have never
> found a system, even one with two CPUs that did not instantly
> reset.

All you are doing is causing a triple fault, started with most likely an
invalid op fault.  There are many ways of doing that, including the no
idt way the kernel currently uses, which IMHO would be more reliable
that depending on the processor crashing on random memory.

--

				Brian Gerst
