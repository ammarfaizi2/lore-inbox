Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315260AbSHVRpw>; Thu, 22 Aug 2002 13:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315265AbSHVRpw>; Thu, 22 Aug 2002 13:45:52 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:20363 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S315260AbSHVRpv>; Thu, 22 Aug 2002 13:45:51 -0400
Date: Thu, 22 Aug 2002 19:46:55 +0200
From: Dominik Brodowski <devel@brodo.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Gabriel Paubert <paubert@iram.es>,
       Yoann Vandoorselaere <yoann@prelude-ids.org>,
       cpufreq@lists.arm.linux.org.uk, cpufreq@www.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: fix 32bits integer overflow in loops_per_jiffy calculation
Message-ID: <20020822194655.C2016@brodo.de>
References: <20020822185107.A1160@brodo.de> <20020822193516.15445@192.168.4.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20020822193516.15445@192.168.4.1>; from benh@kernel.crashing.org on Thu, Aug 22, 2002 at 09:35:16PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2002 at 09:35:16PM +0200, Benjamin Herrenschmidt wrote:
> >IMHO per-arch functions are really not needed. The only architectures which
> >have CPUFreq drivers by now are ARM and i386. This will change, hopefully;
> >IMHO it should be enough to include some basic limit checking in 
> >cpufreq_scale().
> 
> In this specific case, we were talking about PPC since the problem
> occured when I implemented cpufreq support to switch the speed
> of the latest powerbooks between 667 and 800Mhz

And the patch from Yoann solves this? Then it might be easiest to use this
for the time being, and switch to George Anzinger's sc_math.h once 
high-res-timer is merged.

Dominik
