Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbTJHSXS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 14:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbTJHSXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 14:23:18 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:25987 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261580AbTJHSXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 14:23:17 -0400
Subject: Re: Time precision, adjtime(x) vs. gettimeofday
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20031008175059.GA31743@iram.es>
References: <1065619951.25818.15.camel@gaston>
	 <20031008154846.GA29868@iram.es> <1065630178.26943.54.camel@gaston>
	 <20031008175059.GA31743@iram.es>
Content-Type: text/plain
Message-Id: <1065637323.897.12.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 08 Oct 2003 20:22:04 +0200
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: benh@kernel.crashing.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I repeat the question: what are the values of drift on the machines
> that encounter the problem ? Is this drift stable or unstable?

So far, there is no problem. The problem that was happening
was a via_calibrate_decr() bug with HZ != 100, but when
investigating, I figured out that we had a potential problem
there, that's all and that's why I want people like you who
know those problems well to state if it's worth bothering ;)
> >
> > On all cases, those will drift some way from what the NTP server will
> > give, either a lot or not, it will. So we may end up adjusting our
> > kernel rate and thus opening a window for the problem.
> 
> The worst variations of drift I've seen are a few ppm for a given
> machine, barring the occasional boot-time calibration problems that
> I have encountered.

OK.



