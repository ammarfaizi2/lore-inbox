Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278705AbRJTAh5>; Fri, 19 Oct 2001 20:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278706AbRJTAht>; Fri, 19 Oct 2001 20:37:49 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:11537 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S278705AbRJTAhk>; Fri, 19 Oct 2001 20:37:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "M. Edward Borasky" <znmeb@aracnet.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: Which is better at vm, and why? 2.2 or 2.4
Date: Sat, 20 Oct 2001 02:38:52 +0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <HBEHIIBBKKNOBLMPKCBBKEOIDOAA.znmeb@aracnet.com>
In-Reply-To: <HBEHIIBBKKNOBLMPKCBBKEOIDOAA.znmeb@aracnet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011020003812Z16243-4005+727@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On October 13, 2001 08:06 pm, M. Edward Borasky wrote:
> Linux certainly has the measurement capabilities; I've been able to find
> everything I need in /proc for the monitoring and analysis I need to do. On
> the control knobs, I think Linux falls short relative to, say, Solaris,
> Tru64, VMS and Windows 2000. Nearly all decisions seem to be "hard-wired" in
> Linux, for example, the goodness boosts given to processes to promote soft
> affinity, the time slice, and the fractions of memory allocated to the
> various functions: buffers, cached, etc. They are set as #defines in header
> files. Even having them as variables would be an improvement; then they
> could be examined and modified with a debugger.

It's because Linus wants it that way, with a view to encouraging the 
development of algorithms that work well across a broad range of 
configurations without requiring a lot of tuning.  So it's a case of short 
term pain for long term gain.

Keep in mind that once you start exposing tuning parameters you tend to get 
lots of user programs out there that break without the parameters, or if the 
parameters don't behave the same way across versions.  Official tuning 
parameters also get in the way of trying out new algorithms, which might not 
even support the old tweaks, for example.

> I would like to be able to set up a test system in my laboratory, fire up a
> benchmark that emulates a real-world workload and tweak these parameters
> somewhere in /proc in real time, while watching the response times of my
> benchmark transactions. I can do this in Tru64, I can do this in a number of
> other operating systems. Right now, for all practical purposes, when I want
> to perform an experiment like this, I need to recompile, quite often, the
> *entire* kernel, reboot and re-run my benchmark. In other words, if the
> parameters were tunable, what now takes *days* to do could be accomplished
> in hours, even minutes, with just a little up-front work.

So then you probably just want to grab one of the many patches that expose 
things through proc and use it as a jumping-off point to expose your own 
tweaks.  As you say, much faster than recompiling every time.

--
Daniel
