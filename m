Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268251AbTALHAb>; Sun, 12 Jan 2003 02:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268250AbTALHAa>; Sun, 12 Jan 2003 02:00:30 -0500
Received: from mail.webmaster.com ([216.152.64.131]:53488 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S268249AbTALHA2> convert rfc822-to-8bit; Sun, 12 Jan 2003 02:00:28 -0500
From: David Schwartz <davids@webmaster.com>
To: <mark@mark.mielke.cc>
CC: Linux kernel list <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.63 (1077) - Licensed Version
Date: Sat, 11 Jan 2003 23:09:13 -0800
In-Reply-To: <20030112061654.GB15442@mark.mielke.cc>
Subject: Re: Nvidia and its choice to read the GPL "differently"
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20030112070914.AAA21737@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jan 2003 01:16:54 -0500, Mark Mielke wrote:

>Atrocious how? My qualification "without significant side effects"
>means just that - *without* *significant* *side* *effects*. Note 
>that
>I did not say web clients, but that below you assume web clients. I
>don't know about you, but I don't consider a web server to be an RT
>application.

	I don't understand how you could possibly say this. Any application 
that was using an RTOS does so because it has requirements that must 
be met. Switching from an RTOS to a non-RTOS means that you can't 
provide those guarantees anymore, which is a significant side effect.

>>    Perhaps Linux can handle more web clients than vxWorks, but can
>>Linux guarantee that if the temperature in the core coolant exceeds

>>350 degrees, the secondary pump circuit will be activated within 13
>>milliseconds?

>If you truly wanted to fit the requirements you list above (350
>degress, secondary pump activated in < 13 milliseconds), I suggest
>you
>use a hardware solution.

	You can't do everything in hard wired hardware and wouldn't want to 
for a large variety of reasons. Hardware is hard to change, hard to 
validate, and hard to test. You're much better off sticking with 
generic, well tested, well understood hardware. However, you *must* 
use an RTOS. Different job, different tool.

>I remain very optimistic that Linux+RT will be able to handle more
>capacity than vxWorks for the majority of RT applications.

	Probably so, but we weren't talking about "Linux+RT", were we? Trust 
me, any real RT code for Linux will cause its performance to drop 
significantly. There will be constant checks for pre-emption, for 
example.

>But... this has gone too far off a dead thread. You obviously like
>vxWorks. Quite a few people I socialize with curse vxWorks. That's
>your freedom and their freedom. I don't want to be part of this
>anymore. :-)  (Private query: What does webmaster.com use vxWorks
>for?)

	No, I've never used vxWorks, I just understand the difference 
between an RTOS and a non-RTOS and how to choose the right tool for 
the job. If an application can run on an OS that is not an RTOS, it 
almost always does. RTOSes are usually used where you *must* *have* 
guarantees.

	It is extremely handy for many problems to be able to guarantee that 
you can turn the pump on within 13 milliseconds without having to 
hard wire a specific circuit for that. This is the problem domain 
RTOSes were meant for. This has inevitable overhead. If you need to 
meet specific time requirements, then the overhead is a low price to 
pay.

	Most applications that require RTOSes don't need a lot of computing. 
Controlling a nuclear power plant takes less CPU power than playing 
Solitaire on a GUI. A P3 can easily provide 13 millisecond response 
time without breaking a sweat, but not running a general purpose OS. 
That doesn't mean we should all run RTOSes.

	That you would even dream of comparing the performance of an RTOS to 
a non-RTOS as a way of comparatively evaluating two operating systems 
suggests you don't understand what an RTOS actually is. You're not 
alone, by the way, I once had a conversation with the product manager 
for a leading RTOS and quickly discovered he had no idea what an RTOS 
was either. He was under the misconception that real time means high 
performance.

	DS


