Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290817AbSAaBks>; Wed, 30 Jan 2002 20:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290811AbSAaBkf>; Wed, 30 Jan 2002 20:40:35 -0500
Received: from bdsl.66.13.29.10.gte.net ([66.13.29.10]:33926 "EHLO
	Bluesong.NET") by vger.kernel.org with ESMTP id <S290817AbSAaBjj>;
	Wed, 30 Jan 2002 20:39:39 -0500
Message-Id: <200201310144.g0V1iJs26742@Bluesong.NET>
Content-Type: text/plain; charset=US-ASCII
From: "Jack F. Vogel" <jfv@trane.bluesong.net>
Reply-To: jfv@bluesong.net
To: m.knoblauch@TeraPort.de
Subject: Re: [PATCH]: O(1) 2.4.17-J7 Tuneable Parameters
Date: Wed, 30 Jan 2002 17:44:18 -0800
X-Mailer: KMail [version 1.3.1]
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        jfv@us.ibm.com
In-Reply-To: <3C57F347.26527F73@TeraPort.de>
In-Reply-To: <3C57F347.26527F73@TeraPort.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 January 2002 05:21 am, Martin Knoblauch wrote:
> > [PATCH]: O(1) 2.4.17-J7 Tuneable Parameters
>
>
>  How big is the actual degradation in your test? IIR, Ingo is afraid
> that the tunables could easily screw things up, which of course is true.
> What about adding a kernel-build option that leaves the sysctl interface
> read-only by default and enables writing only if it is requested at
> build time?

Running on a machine that I dont think I can really officially give numbers..
However, lets say that without the tuneable code you got a run of hackbench
doing 60 groups that took 8.27 secs, when the tuneable code is in it went
to a whopping 8.6 secs :)

The results at least on this benchmark were all in that decimal noise.

As for a build option, if the code were integrated I might see that as 
making sense, but as this is a developmental patch the user is expected
to know what they are doing. Only root can write anything to the parameters
as well.

Cheers,

-- 
Jack F. Vogel
IBM  Linux Solutions
jfv@us.ibm.com  (work)
jfv@Bluesong.NET (home)
