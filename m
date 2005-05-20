Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbVETTGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbVETTGE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 15:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVETTGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 15:06:04 -0400
Received: from colin.muc.de ([193.149.48.1]:5641 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261551AbVETTFy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 15:05:54 -0400
Date: 20 May 2005 21:05:50 +0200
Date: Fri, 20 May 2005 21:05:50 +0200
From: Andi Kleen <ak@muc.de>
To: George Anzinger <george@mvista.com>
Cc: joe.korty@ccur.com, robustmutexes@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] A more general timeout specification
Message-ID: <20050520190550.GB57598@muc.de>
References: <20050518201517.GA16193@tsunami.ccur.com> <m1hdh0yu14.fsf@muc.de> <428CC6B5.3070206@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428CC6B5.3070206@mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think the accepted and standard way to do this is to use different 
> "clock"s. For example, in the HRT patch the clocks CLOCK_REALTIME_HR and 
> CLOCK_MONOTONIC_HR are defined as high resolution clocks.

Note precision here can be fairly long - some timers dont even
if they run a minute earlier or later or even longer. For others
it can be rather small.

I dont think you want own clocks for all possible numbers. It makes
much more sense to give a numerical time offset.

-Andi
