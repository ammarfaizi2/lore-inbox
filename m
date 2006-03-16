Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752313AbWCPLb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752313AbWCPLb4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 06:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752285AbWCPLb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 06:31:56 -0500
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:46521 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1752120AbWCPLbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 06:31:55 -0500
From: Con Kolivas <kernel@kolivas.org>
To: ck@vds.kolivas.org
Subject: Re: [ck] Re: does swsusp suck after resume for you?
Date: Thu, 16 Mar 2006 22:31:27 +1100
User-Agent: KMail/1.9.1
Cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>, Pavel Machek <pavel@suse.cz>,
       Stefan Seyfried <seife@suse.de>,
       Jun OKAJIMA <okajima@digitalinfra.co.jp>, linux-kernel@vger.kernel.org
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <20060315175948.GB2423@ucw.cz> <200603162133.26771.kernel@kolivas.org>
In-Reply-To: <200603162133.26771.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603162231.28014.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 March 2006 21:33, Con Kolivas wrote:
> On Thursday 16 March 2006 04:59, Pavel Machek wrote:
> > (It will probably suck. In such case, testing Con's patch would be
> > nice -- after trivial fix rafael pointed out).
>
> Ok here's a patch I've booted and tested with a modification to swap
> prefetch that others might find useful, not just swsusp.
>
> The tunable in /proc/sys/vm/swap_prefetch is now bitwise ORed:
> 1	= Normal background swap prefetching when load is light
> 2	= Aggressively swap prefetch as much as possible
>
> And once the "aggressive" bit is set it will prefetch as much as it can and
>  then disable the aggressive bit. Thus if you set this value to 3 it will
>  prefetch aggressively and then drop back to the default of 1. This makes
> it easy to simply set the aggressive flag once and forget about it. I've
> booted and tested this feature and it's working nicely. Where exactly you'd
> set this in your resume scripts I'm not sure. A rolled up patch against
> 2.6.16-rc6-mm1 is here for simplicity:
> http://ck.kolivas.org/patches/swap-prefetch/2.6.16-rc6-mm1-swap_prefetch_su
>spend_test.patch

Wrong rollup sorry! That was the old one.

This is the correct rollup:
http://ck.kolivas.org/patches/swap-prefetch/2.6.16-rc6-mm1-swap_prefetch_test.patch

Cheers,
Con
