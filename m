Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbVHRQ73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbVHRQ73 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 12:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbVHRQ73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 12:59:29 -0400
Received: from mail.aknet.ru ([82.179.72.26]:43268 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S932193AbVHRQ72 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 12:59:28 -0400
Message-ID: <4304BE76.5090003@aknet.ru>
Date: Thu, 18 Aug 2005 20:59:34 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [rfc][patch] API for timer hooks
References: <42FDF744.2070205@aknet.ru>	 <1124126354.8630.3.camel@cog.beaverton.ibm.com> <43024ADA.8030508@aknet.ru>	 <1124244580.30036.5.camel@mindpipe> <430363F2.7090009@aknet.ru>	 <1124296844.3591.7.camel@mindpipe>  <430376B8.9040404@aknet.ru> <1124320620.3591.14.camel@mindpipe>
In-Reply-To: <1124320620.3591.14.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Lee Revell wrote:
>> should set CONFIG_HZ to the value I
>> need at compile-time, and just remove
>> all the timer reprogramming from the
>> driver in a hope the dynamic-tick patch
>> will slow it down itself when necessary?
> The current implementations don't allow HZ to go higher than CONFIG_HZ
> but that's the next logical step.
What I was thinking about, is that I can
just set CONFIG_HZ to the value I need.
It would be a very high value, but with
the dynamic-tick patch it shouldn't hurt. I
don't see how can I use the dynamic-tick
patch otherwise, I actually though this is
how you implied I should use it.
The question with that approach is just how
to set CONFIG_HZ to an arbitrary values
rather than to the 3 pre-defined constants
(shouldn't be difficult), and whether or not
the dynamic-tick patch will be able to slow
the timer down _that_ much:)
That would actually probably be an ideal
solution for my problem - suddenly I don't
need to change the timer speed at all. The
only limitation would be that when the
speaker driver is enabled in the config,
the ability to manually select the CONFIG_HZ
will be lost, but maybe it is not that bad
at all...

