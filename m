Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262494AbTEIMEn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 08:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262638AbTEIMEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 08:04:43 -0400
Received: from zero.aec.at ([193.170.194.10]:30731 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262494AbTEIMDj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 08:03:39 -0400
Date: Fri, 9 May 2003 14:16:11 +0200
From: Andi Kleen <ak@muc.de>
To: mikpe@csd.uu.se
Cc: Andi Kleen <ak@muc.de>, Ulrich Drepper <drepper@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: hammer: MAP_32BIT
Message-ID: <20030509121611.GA5155@averell>
References: <3EBB5A44.7070704@redhat.com> <20030509092026.GA11012@averell> <16059.37067.925423.998433@gargle.gargle.HOWL> <20030509113845.GA4586@averell> <16059.38513.197275.134938@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16059.38513.197275.134938@gargle.gargle.HOWL>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 09, 2003 at 01:52:17PM +0200, mikpe@csd.uu.se wrote:
> Andi Kleen writes:
>  > 
>  > On Fri, May 09, 2003 at 01:28:11PM +0200, mikpe@csd.uu.se wrote:
>  > > I have a potential use for mmap()ing in the low 4GB on x86_64.
>  > 
>  > Just use MAP_32BIT
> 
> Will that be corrected to use the full 4GB space? 2GB is too small.

That would break the X server.

But what you can do is to use mmap(0x1000, ....) and free the memory
again if the result is bigger than 4GB. If you pass an non zero value
as first argument but not MAP_FIXED it'll use the address argument 
as starting point for the search.

-Andi
