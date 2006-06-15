Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030250AbWFOLoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030250AbWFOLoV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 07:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030257AbWFOLoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 07:44:21 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:52202 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030250AbWFOLoU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 07:44:20 -0400
Date: Thu, 15 Jun 2006 13:40:59 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: clocksource
In-Reply-To: <1149753904.2764.24.camel@leatherman>
Message-ID: <Pine.LNX.4.64.0606151319440.32445@scrub.home>
References: <20060604135011.decdc7c9.akpm@osdl.org> 
 <Pine.LNX.4.64.0606050141120.17704@scrub.home>  <1149538810.9226.29.camel@localhost.localdomain>
  <Pine.LNX.4.64.0606052226150.32445@scrub.home>  <1149622955.4266.84.camel@cog.beaverton.ibm.com>
  <Pine.LNX.4.64.0606070005550.32445@scrub.home> <1149753904.2764.24.camel@leatherman>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 8 Jun 2006, john stultz wrote:

> > This code gets only limited testing in -mm, it needs to run for weeks 
> > or months, which I don't expect from the average -mm kernel. This makes 
> > userspace simulations so damn important and if you don't do this, you're 
> > playing a very risky game with a kernel which is supposed to be stable.
> 
> Agreed, simulation is nice. Thus, I've revived the old simulator which
> builds using the existing code in -mm. Its a bit fast/dirty and isn't
> exactly like your sim, but maybe you can take a look at it and send
> patches to improve it?
> 
> You can find it at:
> http://sr71.net/~jstultz/tod/simulator_C2.tar.bz2

At http://www.xs4all.nl/~zippel/ntp/simulator_C2+patches.tar.bz2 is my 
version where I added a number of patches (all p? patches) to get it into 
an acceptable state. You have a number of bugs which actually didn't let 
the clock oscillate that much but instead added random jitter (and in some 
cases a lot of it).

I disabled the lost interrupt simulation, so the effect of adjustments are 
better visible, the error should return to near zero after it. Look for 
the "ppm" prints and watch the time difference.
In the series file you can enable some debug patches (d?) to add extra 
prints or simulate large update delays to see the effect on the error 
difference.

bye, Roman
