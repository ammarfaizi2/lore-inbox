Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262113AbUKVNkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbUKVNkh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 08:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbUKVNiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 08:38:24 -0500
Received: from apollo.nbase.co.il ([194.90.137.2]:61961 "EHLO
	apollo.nbase.co.il") by vger.kernel.org with ESMTP id S262100AbUKVNfu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 08:35:50 -0500
Message-ID: <41A1EAE0.9080504@mrv.com>
Date: Mon, 22 Nov 2004 15:34:24 +0200
From: emann@mrv.com (Eran Mann)
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-2
References: <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu> <41A1A6E6.5090807@mrv.com> <20041122100140.GD6817@elte.hu>
In-Reply-To: <20041122100140.GD6817@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Eran Mann <emann@mrv.com> wrote:
>>
>>Hi,
>>I´m seeing latencies of up to ~2000 microseconds. see attached traces
>>file for a small sample. I think I´m missing something obvious
>>config-wise but I don´t know what...
...

> this seems to imply IDE DMA related hardware overhead. Apparently what
> happens is that with certain motherboards/chipsets, if IDE DMA happens
> then that DMA transfer _completely locks up_ the system bus. Nothing 
> happens, and the CPU is stalled in essence until the end of the DMA 
> request.
> 
....
> 	Ingo

Right on.
After hdparm -d0 I see maximum latency of 35 us after a full kernel 
build with a few GUI apps in the background. I´ll try to find a 
reasonable compromise.
-- 
Eran Mann
