Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264528AbRFOVgU>; Fri, 15 Jun 2001 17:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264531AbRFOVgN>; Fri, 15 Jun 2001 17:36:13 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:62459 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S264528AbRFOVf4>;
	Fri, 15 Jun 2001 17:35:56 -0400
Date: Fri, 15 Jun 2001 17:35:49 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Paul Faure <paul@engsoc.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.0.35 limits
In-Reply-To: <Pine.LNX.4.33.0106151702300.22155-100000@stout.engsoc.carleton.ca>
Message-ID: <Pine.GSO.4.21.0106151726050.9091-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Jun 2001, Paul Faure wrote:

> Just this morning, our firewall get a kernel panic after 500 days of
> uptime.
> 
> As you can see from the log files, the date starts at June 15th, where we
> get two div by zeros, then jumps May 11th, then a kernel panic. A reboot
> brings it back to June 15th. Since cron could not open /dev/rtc. My first
> thought was an internal kernel limit on the time, but 500 days seems a bit
> short.
> 
> Any ideas ?

(1<<32) / (24 * 60 * 60 * 100) == 497

IOW, 2^32 timer interrupts since the boot.

