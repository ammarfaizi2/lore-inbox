Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262872AbTGMMgl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 08:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264448AbTGMMgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 08:36:41 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:36035 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S262872AbTGMMgj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 08:36:39 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Guillaume Chazarain <gfc@altern.org>
Subject: Re: [RFC][PATCH] SCHED_ISO for interactivity
Date: Sun, 13 Jul 2003 22:53:12 +1000
User-Agent: KMail/1.5.2
References: <JEPOQNA0LFV95MFCPMSKONGFSNX.3f113751@monpc>
In-Reply-To: <JEPOQNA0LFV95MFCPMSKONGFSNX.3f113751@monpc>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307132253.12883.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jul 2003 20:41, Guillaume Chazarain wrote:
> Hi Con,
>
> I am currently testing SCHED_ISO, but I have noticed a regression:
> I do a make -j5 in linux-2.5.75/ everything is OK since gcc prio is 25.
> X and fvwm prio are 15, but when I move a window it's very jerky.

Interesting. I don't know how much smaller the timeslice can be before 
different hardware will be affected. Can you report what cpu and video card 
you're using? Unfortunately I don't have a range of hardware to test it on 
and I chose the aggressive 1/5th timeslice size. Can you try with ISO_PENALTY 
set to 2 instead?

> And btw, as I am interested in scheduler improvements, do you have a
> testcase where the stock scheduler does the bad thing? Preferably without
> KDE nor Mozilla (I don't have them installed, and I'll have access to a
> decent connection in september).

Transparency and antialiased fonts are good triggers. Launcing Xterm with 
transparency has been known to cause skips. Also the obvious make -j 4 kernel 
compiles, and 
while true ; do a=2 ; done
as a fast onset full cpu hog

> BTW2, you all seem to test interactivity with xmms. Just for those like me
> that didn't noticed, I have just found that it skips much less with alsa's
> OSS emulation than with alsa-xmms.

Anything that increases the signal to noise ratio at helping us pick up 
skips/problems is useful, but this can help those that _don't_ want skips so 
thanks.

> Thanks,

Thank you very much for testing and reporting.

Con

