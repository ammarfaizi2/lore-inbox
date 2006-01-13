Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422762AbWAMSEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422762AbWAMSEI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 13:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422763AbWAMSEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 13:04:08 -0500
Received: from uproxy.gmail.com ([66.249.92.206]:18490 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422762AbWAMSEH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 13:04:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pn0kkokoCg9KI04fKx92Xhs7sGhYI61sPIBYvdHt+OPs2qiXCgbV6yFCwCdDx+AthMRoXjyad3LByaVPc8zOh1OLkMAbsVrOZT6S5vzwFU6P2TQyhYAcRtff5o7LJgxSInt6h//OqSjDvUYKMjMdreAXfGK1Z+TrbtekiNiOqBY=
Message-ID: <728201270601131004l6a3ed526q3846d4c485e3fc07@mail.gmail.com>
Date: Fri, 13 Jan 2006 12:04:04 -0600
From: Ram Gupta <ram.gupta5@gmail.com>
To: Jim MacBaine <jmacbaine@gmail.com>
Subject: Re: /proc/sys/vm/swappiness == 0 makes OOM killer go beserk
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3afbacad0601130843k6cf548e5y638b9ae3434096fa@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3afbacad0601130755x507047eeqfdcfb1e54a163cdd@mail.gmail.com>
	 <728201270601130832h37eae980hc4e0d3de7522c81e@mail.gmail.com>
	 <3afbacad0601130843k6cf548e5y638b9ae3434096fa@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/06, Jim MacBaine <jmacbaine@gmail.com> wrote:
> On 1/13/06, Ram Gupta <ram.gupta5@gmail.com> wrote:
> It _would_ be ok if swappiness == 0 would mean that the kernel will
> not swap at all. That's not the case. Even without an excessive use of
> tmpfs the kernel found ~250 MB of unused memory which it swapped out
> during the last days with swappiness == 0.
>
> Regards,
> Jim
>

I correct myself. swappiness == 0 does not mean that kernel will not try to
 swap at all but this value decreases the swapping.
swap_tendency = mapped_ratio / 2 + distress + vm_swappiness;

swap_tendency depends on swappiness and affects the memory reclaimation.

Regards
Ram Gupta
