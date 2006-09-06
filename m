Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751061AbWIFN5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbWIFN5K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 09:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbWIFN5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 09:57:10 -0400
Received: from relay03.pair.com ([209.68.5.17]:56330 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S1751061AbWIFN5H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 09:57:07 -0400
X-pair-Authenticated: 71.197.50.189
Date: Wed, 6 Sep 2006 08:54:22 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: Chase Venters <chase.venters@clientec.com>
cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Johann Borck <johann.borck@densedata.com>
Subject: Re: [take16 1/4] kevent: Core files.
In-Reply-To: <Pine.LNX.4.64.0609060824090.18512@turbotaz.ourhouse>
Message-ID: <Pine.LNX.4.64.0609060850150.18512@turbotaz.ourhouse>
References: <1157543723488@2ka.mipt.ru> <Pine.LNX.4.64.0609060824090.18512@turbotaz.ourhouse>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Sep 2006, Chase Venters wrote:

>>  +	if (start + num >= KEVENT_MAX_EVENTS ||
>>  +			start >= KEVENT_MAX_EVENTS ||
>>  +			num >= KEVENT_MAX_EVENTS)
>
> Since start and num are unsigned, the last two checks are redundant. If start 
> or num is individually >= KEVENT_MAX_EVENTS, start + num must be.
>

Actually, my early-morning brain code optimizer is apparently broken, 
because it forgot all about integer wraparound. Disregard please.

>
> Thanks,
> Chase
>
