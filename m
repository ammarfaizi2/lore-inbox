Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264728AbUE0PN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264728AbUE0PN1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 11:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264734AbUE0PN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 11:13:27 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:24390 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264728AbUE0PNS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 11:13:18 -0400
From: Matthias Fouquet-Lapar <mfl@kernel.paris.sgi.com>
Message-Id: <200405271502.i4RF2F3X002327@mtv-vpn-hw-mfl-1.corp.sgi.com>
Subject: Re: Hot plug vs. reliability
To: Zoltan.Menyhart@bull.net
Date: Thu, 27 May 2004 17:02:14 +0200 (CEST)
Cc: mfl@kernel.paris.sgi.com (Matthias Fouquet-Lapar),
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <40B5FF96.44F9EE15@nospam.org> from "Zoltan Menyhart" at May 27, 2004 04:47:51 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I agree, in this case there is no loss of MTBF.
> Yet let's call this activity as run time re-partitioning of the machine.
> (Most people - me too - consider hot plugging as physically plugging
> things in / out.)

You're right, it's confusing and I made the same assumptions you make :
physically moving parts. (and I worked on a systems a couple of years
back where we actually had hotswap :-))

> But the new comers are tested in a different environment, with
> different tolerance range. I just simply do not trust :-)

Not really. It's up to the vendor and at least here at SGI we have pretty
tight rules and tolerances.

> I do not think the timing / the delays are auto adjusting. You select
> a component X to work next to the component Y because you know that
> X in "here" and Y in "there" in the tolerance range...

They do (impedance match). An example are SRAMs used for CPUs with external 
caches for example.  I've learned a lot about that :-)). You also
have stuff like auto-learning for echo-clock timings etc, but this is really
very platform and CPU specific

> I think the OS has to be platform independent. How can a platform independent
> OS know if <n> errors of this / that type requires what intervention ?
> We'll have the same binary of the OS (+ drivers) for a small desk top or
> for a 32 CPU "main frame". Only the firmware is different...

An OS is never platform independent, there always is a machine dependant layer.
I'm not really concerned about the total numbers of errors in a system, 
regardless if we have one, 32 or 512 CPUs. If we see a component starting to 
fail, it should be isolated in order to avoid catastrophic failure

> Most of our clients just do not want to touch their 10 year old rubbish
> Fortran programs. If I get a hint of danger (today it does not come from the FW)
> I could take a check point and call for service intervention...

That's a well know problem (although I think 20 years or more are more 
likely ...)
I think however there are new applications coming up using large or 
ultra-scale systems where more fault tolerance can be designed in at the OS,
libarary or even user level

Amicalement

Matthias Fouquet-Lapar  Core Platform Software    mfl@sgi.com  VNET 521-8213
Principal Engineer      Silicon Graphics          Home Office (+33) 1 3047 4127

