Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbVK3OAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbVK3OAt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 09:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbVK3OAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 09:00:49 -0500
Received: from nproxy.gmail.com ([64.233.182.198]:48457 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751235AbVK3OAs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 09:00:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BPVpqopaFX36jWf9LrZldGkUlTPE9eDBmFyjY5plfQX20IYrQHfug19lXKxbwQsQy+GxlhozsHouJF4ULlIwk8Xm+oICZZ0jqTee492D+++elY4JhIi9T4U45IgEltY3XydWDfU0pgj/vus+2vyiqhe3HDWowNSB9tclR63q73A=
Message-ID: <c216304e0511300600q2d25eae1oca9bc0eb2d5df4a3@mail.gmail.com>
Date: Wed, 30 Nov 2005 19:30:46 +0530
From: Ashutosh Naik <ashutosh.lkml@gmail.com>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: Over-riding symbols in the Kernel causes Kernel Panic
Cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       nagendra_tomar@adaptec.com
In-Reply-To: <4384BE3A.6060505@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <c216304e0511230610x2b983e59h42c10517acd59e63@mail.gmail.com>
	 <4384AAED.3070804@tmr.com>
	 <9a8748490511231004l36edcf57mf0fb63c4a9e17f49@mail.gmail.com>
	 <4384BE3A.6060505@tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/05, Bill Davidsen <davidsen@tmr.com> wrote:

>>I've not looked at what it would take to do that, nor what measures
>>are currently in place, *at all*, but as I see it, all it would take
>>would be some "tag" present for each message stating if it was "build
>>in", or "currently loaded as a module", then on each module load check
>>the "tag" of the to-be-loaded module against the list of current
>>in-kernel tags, then reject if already on the list.
>>I can't see why there would be a catch...

> It doesn't look to be quite as easy to check for built-in as to check
> for "already loaded" without some global state tracking, and handling
> the case where it just wasn't built at all, and may have other stuff
> missing. Add to this not breaking existing out of tree code and the
> implementation looks like a non-trivial exercise.

I am currently working on a preliminary patch which addresses this
issue. A module wont be able to load any symbol, which already exists
in the kernel symbol table.

Regards
Ashutosh
