Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267953AbUJSFGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267953AbUJSFGd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 01:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267961AbUJSFGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 01:06:33 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:19461 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S267953AbUJSFGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 01:06:31 -0400
Date: Tue, 19 Oct 2004 07:06:17 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Alexander Clouter <alex-kernel@digriz.org.uk>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Con Kolivas <kernel@kolivas.org>, cpufreq@www.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq_ondemand
Message-ID: <20041019050616.GI19761@alpha.home.local>
References: <88056F38E9E48644A0F562A38C64FB60031DA073@scsmsx403.amr.corp.intel.com> <20041018083905.GC3311@inskipp.digriz.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041018083905.GC3311@inskipp.digriz.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 18, 2004 at 09:39:05AM +0100, Alexander Clouter wrote:
> I'm all for "this really should be done in userspace", but for something like 
> this I have a nagging feeling that its neater in kernel-space.  Of course the 
> userspace one has the advantage (I think cpufreqd does it) that you can 
> decide if you want to increase the freq depending on what applications are 
> running.

Well, I've used a very simple daemon I wrote for more than a year now on a
vaio, and considering that I sometimes wanted to change it or even stop it,
I clearly prefer it in userspace than in kernel. It was so convenient to
issue a "killall cpufrqd" whenever I wanted 'time' to return accurate values
on a particular process, that I cannot imagine what it would have been if it
had been in the kernel. Moreover, the vaio was unreliable with certain
intermediate frequencies, and it too me a lot of time to discover this
(burnBX was the only reliable trigger). I simply had to change a few lines
in my daemon to use different frequencies and that was all.

Cheers,
Willy

