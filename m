Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263933AbTH1KSX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 06:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263891AbTH1KQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 06:16:26 -0400
Received: from h-66-167-79-230.SNVACAID.covad.net ([66.167.79.230]:645 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP id S263908AbTH1KQR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 06:16:17 -0400
Date: Thu, 28 Aug 2003 03:16:20 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200308281016.h7SAGKi24571@freya.yggdrasil.com>
To: ttsig@tuxyturvy.com
Subject: Re: Poor IPSec performance with 2.6 kernels
Cc: jmorris@intercode.com.au, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 2003-08-28 2:56:37, James Morris wrote:
>On 27 Aug 2003, Tom Sightler wrote:
>
>> My Internet connection is a DSL circuit that typically delivers about
>> 150KB/s.  When I connect with SuperFreeS/WAN my VPN throughput is quite
>> good, averaging about 125KB/s (this seems about reasonable with
>> overhead) but when making the identical connection with racoon and the
>> 2.6 kernel I can only achieve 50KB/s.  I've been unable to come up with
>> any reason why this would be the case.
>> 
>> Any hints would be appreciated.
>
>I think SFS uses assembly crypto algorithms where possible, which would 
>account for roughly 2x performance increase.

	I believe that assembly AES processes about 50MB/second on a
1GHz machine, but Tom is talking about the difference between 125kB/sec.
and 50kB/sec.  The C versus assembly issue is not on the scale that
Tom is asking about.

	Tom, although I'm not sure that I'll immediately have the time
to dig into your problem, I think it would increase the likelihood of
someone tracking it down if you could answer the following questions.

	In which direction did you take these benchmarks, inbound to the
Linux box, outbound from the Linux box, or both?  If both, is
there a difference between inbound and outbound performance?  What
private key algorithm are you configuring (aes, des, serpent)?  How
is your DSL connected (via ethernet, via USB, such as with SpeedStream)?
What kind of CPU are you using (probably doesn't matter, even if you're
using a 16MHz 386, but it would help in reproducing your problem to
know what the benchmarks should look like on a different system).

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
