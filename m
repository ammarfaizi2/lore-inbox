Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264741AbTGBGG2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 02:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264753AbTGBGG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 02:06:28 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:44432 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S264741AbTGBGGZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 02:06:25 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Roberto Orenstein <orenstein@brturbo.com>, linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] O1int with contest
Date: Wed, 2 Jul 2003 16:24:32 +1000
User-Agent: KMail/1.5.2
References: <1057120014.7919.23.camel@localhost.localdomain>
In-Reply-To: <1057120014.7919.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307021624.32749.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jul 2003 14:26, Roberto Orenstein wrote:
> Hi guys,
>
> Here are some numbers from three kernels tested on my home machine.
> All threes are 2.5.73 based.
> Vanilla is a plain one, O1int-0307020011 is the latest (as I last
> checked) O1int patch w/o the granularity patch, and
> O1int-granu-0307020011 is the former with granularity.

Thanks for doing these.

> One can see that with granularity, the kernel compile suffers a bit, but
> the response is usually high. In my machine, this was the kernel with
> the best responsiveness.

Can you please describe your experiences? The more feedback I get the more I 
can get it working well.

> Each kernel was run once, except O1int-0307020011 with three iterations.
> This was the first I tested, and as soon I noticed the time it took, I
> decided to run once the others 8). Maybe this has some bad influence on
> the results. I appreciate any comments...

Ok well here is my summary of the situation. My patch has virtually no effect 
on contest results (except perhaps io_other). This is good because my earlier 
attempts did affect it, and possibly starved some of the loads. Dare I say 
it, contest is not very good at picking up _these_ sort of scheduler tweaks 
unless they do something wrong. Sorry if my system responsiveness benchmark 
doesn't show this effect; I think they're different. This is more about 
picking the right thing to give preference to. There's a long discussion in 
that, but I'll try not to get into it.

By the way it doesn't look like your dbench in dbench load actually worked.

O1int still remains a work in progress.

Con

