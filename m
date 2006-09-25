Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751410AbWIYRoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbWIYRoP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 13:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWIYRoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 13:44:15 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:1692 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751391AbWIYRoO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 13:44:14 -0400
Date: Mon, 25 Sep 2006 19:38:36 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: ray-gmail@madrabbit.org
cc: john stultz <johnstul@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 -mm merge plans (NTP changes)
In-Reply-To: <2c0942db0609251004h288818c9k4f1c8684b956b72@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0609251929030.6761@scrub.home>
References: <20060920135438.d7dd362b.akpm@osdl.org>  <1158805731.8648.54.camel@localhost>
  <Pine.LNX.4.64.0609211217190.6761@scrub.home>  <1159203005.8288.16.camel@localhost>
 <2c0942db0609251004h288818c9k4f1c8684b956b72@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 25 Sep 2006, Ray Lee wrote:

> On 9/25/06, john stultz <johnstul@us.ibm.com> wrote:
> > I was able to run tests for two days each w/ and w/o the patch I had
> > concerns about. And indeed, it seems if the drift file is reset, the
> > initial convergence is much slower (and this is really what worried me).
> > However once it converges it seems to keep sync as well as the current
> > code.
> 
> So slower convergence isn't a regression?

Not really, it makes the clock more stable and less suspectible to 
network delays.
I think a big part of the problem is that our calibration code could use 
some improvements, I've seen some widely different initial drift values 
from one reboot to the next, which is the main reason ntp has to do that 
much initial work in the first place.

bye, Roman
