Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933080AbWFWMRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933080AbWFWMRv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 08:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933086AbWFWMRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 08:17:51 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:59922 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S933080AbWFWMRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 08:17:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=PIrz0l09xI3blkkTYrdRVlgPoNgDgQp8ivAOCOp++soXxFdJJgHwg2XEh/XJdOhRKt06MQ6bhvyB0xU0Yfd6GJqTZn5FEibioy3DC+xsBrFFlXIDWW/WZXLAU6PG6nKswFpcPHboZLYbEkpxqFENKT6MtHg3g4SOaCCVAdevaQ4=
Message-ID: <449BDCF5.6040808@innova-card.com>
Date: Fri, 23 Jun 2006 14:22:13 +0200
Reply-To: franck.bui-huu@innova-card.com
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Mel Gorman <mel@skynet.ie>
CC: Franck Bui-Huu <vagabon.xyz@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm1
References: <20060621034857.35cfe36f.akpm@osdl.org> <449AB01A.5000608@innova-card.com> <Pine.LNX.4.64.0606221617420.5869@skynet.skynet.ie> <449ABC3E.5070609@innova-card.com> <Pine.LNX.4.64.0606221649070.5869@skynet.skynet.ie> <cda58cb80606221025y63906e81wbec9597b94069b6a@mail.gmail.com> <20060623102037.GA1973@skynet.ie>
In-Reply-To: <20060623102037.GA1973@skynet.ie>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <fbh.work@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman wrote:
> On (22/06/06 19:25), Franck Bui-Huu didst pronounce:
>>>>
>>> I know, but what I'm getting at is that ARCH_PFN_OFFSET may be unnecessary
>>> with flatmem-relax-requirement-for-memory-to-start-at-pfn-0.patch applied.
>> yes it seems so. But ARCH_PFN_OFFSET has been used before your patch
>> has been sent. So your patch seems to be incomplete...
> 
> Difficult to argue with that logic.
> 

sorry, I was just meaning that ARCH_PFN_OFFSET had been introduced to
solve this before your patch has been sent. So the requirement for
memory to start at pfn 0 is already solved.

Your patch solves the problem in a different way, but it's
incompatible with the current one (ARCH_PFN_OFFSET).

IMHO the question is now, which method is the best one ? If it's yours
the we probably need to get ride of the previous method and add yours
(but don't forget to modify arch such ARM which are currently using
ARCH_PFN_OFFSET).

		Franck
