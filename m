Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269024AbUJEOW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269024AbUJEOW0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 10:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269028AbUJEOW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 10:22:26 -0400
Received: from mail23.syd.optusnet.com.au ([211.29.133.164]:14761 "EHLO
	mail23.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S269024AbUJEOWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 10:22:24 -0400
Message-ID: <4162AE07.7030701@kolivas.org>
Date: Wed, 06 Oct 2004 00:21:59 +1000
From: Con Kolivas <lkml@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dominik Karall <dominik.karall@gmx.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm2
References: <20041004020207.4f168876.akpm@osdl.org> <200410051607.40860.dominik.karall@gmx.net>
In-Reply-To: <200410051607.40860.dominik.karall@gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Karall wrote:
> On Monday 04 October 2004 11:02, Andrew Morton wrote:
> 
>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6
>>.9-rc3-mm2/
> 
> 
> some more scheduling/preempt problems. following patches were applied:
> +               preempt_disable();                                      \
> +               per_cpu(ip_conntrack_stat, smp_processor_id()).count++; \
> +               preempt_disable();                                      \

double preempt_disable looks suspect.

Con
