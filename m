Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbVHQRlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbVHQRlK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 13:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbVHQRlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 13:41:10 -0400
Received: from mail.aknet.ru ([82.179.72.26]:42250 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1751173AbVHQRlJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 13:41:09 -0400
Message-ID: <430376B8.9040404@aknet.ru>
Date: Wed, 17 Aug 2005 21:41:12 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
Cc: john stultz <johnstul@us.ibm.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [rfc][patch] API for timer hooks
References: <42FDF744.2070205@aknet.ru>	 <1124126354.8630.3.camel@cog.beaverton.ibm.com> <43024ADA.8030508@aknet.ru>	 <1124244580.30036.5.camel@mindpipe>  <430363F2.7090009@aknet.ru> <1124296844.3591.7.camel@mindpipe>
In-Reply-To: <1124296844.3591.7.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Lee Revell wrote:
> Lots of things aren't doable with the current timer API, hence all the
> recent work on dynamic tick. 
I've found only this about the dynamic
tick:
http://lwn.net/Articles/138969/
and it seems that it is intended only
to slow down the interrupts when there
is no work to do, rather than to allow
setting an arbitrary frequencies or something
like that.
I guess now I realized how you (and Nish)
assume I could use it: is it that I
should set CONFIG_HZ to the value I
need at compile-time, and just remove
all the timer reprogramming from the
driver in a hope the dynamic-tick patch
will slow it down itself when necessary?
Or am I misunderstanding the suggestion?
That would be really excellent, but
it there a patch around that allows to
set an arbitrary CONFIG_HZ values, or should
I try to code up one myself? I think
I tried that a few years ago, and the
code all around the kernel was resisting
to work with HZ>1000, but I guess now
it was all changed.

