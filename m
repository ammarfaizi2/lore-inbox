Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262394AbVGHJlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262394AbVGHJlo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 05:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262401AbVGHJlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 05:41:44 -0400
Received: from smtp1.netcabo.pt ([212.113.174.28]:5140 "EHLO
	exch01smtp11.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S262394AbVGHJlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 05:41:42 -0400
Message-ID: <28798.195.245.190.94.1120815616.squirrel@www.rncbc.org>
In-Reply-To: <20050708085253.GA1177@elte.hu>
References: <1119370868.26957.9.camel@cmn37.stanford.edu>
    <20050621164622.GA30225@elte.hu>
    <1119375988.28018.44.camel@cmn37.stanford.edu>
    <1120256404.22902.46.camel@cmn37.stanford.edu>
    <20050703133738.GB14260@elte.hu>
    <1120428465.21398.2.camel@cmn37.stanford.edu>
    <24833.195.245.190.94.1120761991.squirrel@www.rncbc.org>
    <20050707194914.GA1161@elte.hu>
    <49943.192.168.1.5.1120778373.squirrel@www.rncbc.org>
    <57445.195.245.190.94.1120812419.squirrel@www.rncbc.org>
    <20050708085253.GA1177@elte.hu>
Date: Fri, 8 Jul 2005 10:40:16 +0100 (WEST)
Subject: Re: realtime-preempt-2.6.12-final-V0.7.51-11 glitches [no more]
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20050708104016_66407"
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 08 Jul 2005 09:41:40.0568 (UTC) FILETIME=[3E278D80:01C583A1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20050708104016_66407
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 8bit

>>   ------------------------------ ------------- -------------
>>                                  RT-V0.7.51-13 RT-V0.7.49-01
>>   ------------------------------ ------------- -------------
>
>>   Delay Maximum . . . . . . . . :      333           295     usecs
>>   Cycle Maximum . . . . . . . . :      970           943     usecs
>>   Average DSP Load. . . . . . . :       45.7          44.4   %
>>   Average CPU System Load . . . :       15.6          16.3   %
>>   Average CPU User Load . . . . :       32.0          30.1   %
>
> i'm wondering - is this slight increase in CPU utilization (and
> latencies) due to natural fluctuations, or is it a genuine overhead
> increase?
>

I'm pretty confortable in saying that both results are almost equivalent,
the slight differences probably due to environmental effects. All tests
were conducted from a regular user konsole screen, under KDE 3.3 and
perfectly functional X.org desktop session. Runlevel 5 with network down
however. Oh, gkrellm is also on screen :)

OTOH, I'll take this chance to show you something that is annoying me for
quite some time. Just look to the attached chart where I've marked the
spot with an arrow and a question mark. Its just one example of a strange
behavior/phenomenon while running the jack_test4.2 test on PREEMPT_RT
kernels: the CPU usage, which stays normally around 50%, suddenly jumps to
60% steady, starting at random points in time but always some time after
the test has been started. Note that this randomness surely adds to the
the slight differences found on the above results.

First suspicions gone to cpu frequency/throttling, but I have it disabled
on every kernel I build. Denormals? Don't think so, as jack_test_client is
specially coded to treat floats as zero if below 1E-6.

Any hints?
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org
------=_20050708104016_66407
Content-Type: image/x-png;
      name="jack_test4-2.6.12-RT-V0.7.51-13.0-200507080917.png"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
      filename="jack_test4-2.6.12-RT-V0.7.51-13.0-200507080917.png"

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
------=_20050708104016_66407--


