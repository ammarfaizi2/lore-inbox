Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751001AbWCNFMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbWCNFMx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 00:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751817AbWCNFMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 00:12:53 -0500
Received: from mail27.syd.optusnet.com.au ([211.29.133.168]:55505 "EHLO
	mail27.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751001AbWCNFMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 00:12:53 -0500
From: Con Kolivas <kernel@kolivas.org>
To: ck@vds.kolivas.org
Subject: Re: does swsusp suck after resume for you? [was Re: Faster resuming of suspend technology.]
Date: Tue, 14 Mar 2006 16:13:10 +1100
User-Agent: KMail/1.8.3
Cc: Pavel Machek <pavel@ucw.cz>, Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Jun OKAJIMA <okajima@digitalinfra.co.jp>, linux-kernel@vger.kernel.org
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <20060313113631.GA1736@elf.ucw.cz> <200603132303.18758.kernel@kolivas.org>
In-Reply-To: <200603132303.18758.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603141613.10915.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Mar 2006 11:03 pm, Con Kolivas wrote:
> On Monday 13 March 2006 22:36, Pavel Machek wrote:
> > 4) Congratulations, you are right person to help. Could you test if
> > Con's patches help?
>
> Ok this patch is only compile tested only but is reasonably straight
> forward. (I have no hardware to test it on atm). It relies on the previous
> 4 patches I sent out that update swap prefetch. To make it easier here is a
> single rolled up patch that goes on top of 2.6.16-rc6-mm1:
>
> http://ck.kolivas.org/patches/swap-prefetch/2.6.16-rc6-mm1-swap_prefetch_su
>spend_test.patch

Since my warning probably scared anyone from actually trying this patch I've 
given it a thorough working over on my own laptop, booting with mem=128M. The 
patch works fine and basically with the patch after resuming from disk I have 
25MB more memory in use with pages prefetched from swap. This makes a 
noticeable difference to me. That's a pretty artificial workload, so if 
someone who actually has lousy wakeup after resume could test the patch it 
would be appreciated.

Cheers,
Con
