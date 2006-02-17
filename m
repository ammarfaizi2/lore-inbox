Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751442AbWBQO11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbWBQO11 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 09:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWBQO11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 09:27:27 -0500
Received: from mail03.syd.optusnet.com.au ([211.29.132.184]:51675 "EHLO
	mail03.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751442AbWBQO10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 09:27:26 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Kevin Radloff <radsaq@gmail.com>
Subject: Re: [ck] [PATCH] mm: implement swap prefetching (v26)
Date: Sat, 18 Feb 2006 01:26:57 +1100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, ck list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Bart Samwel <bart@samwel.tk>
References: <200602172235.40019.kernel@kolivas.org> <3b0ffc1f0602170618u7a1ad877s337de33c0a8f44f9@mail.gmail.com>
In-Reply-To: <3b0ffc1f0602170618u7a1ad877s337de33c0a8f44f9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602180126.58519.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 February 2006 01:18, Kevin Radloff wrote:
> On 2/17/06, Con Kolivas <kernel@kolivas.org> wrote:
> > Added disabling of swap prefetching when laptop_mode is enabled.
>
> Why bother with this? As someone commented in a previous thread,
> wouldn't it be better to let the laptop_mode script handle it?

The discussion was about what size to make the swap prefetching. Since the 
size is not user tunable any more that is not the case. I had an offlist 
discussion with Bart Samwel about it and basically if your drive spins down 
at 5 seconds (which is what commonly happens with laptop mode) you will never 
have an opportunity to prefetch. This means swap prefetch will basically 
always spin up the drive nullifying laptop mode. On balance if you care about 
power more than anything to actually set laptop mode I suspect you wont want 
prefetch using any more power.

Cheers,
Con
