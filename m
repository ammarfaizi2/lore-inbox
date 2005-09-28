Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbVI1NDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbVI1NDT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 09:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbVI1NDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 09:03:19 -0400
Received: from fmr23.intel.com ([143.183.121.15]:1765 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751285AbVI1NDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 09:03:19 -0400
Date: Wed, 28 Sep 2005 06:03:06 -0700
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, Bob Picco <bob.picco@hp.com>
Subject: Re: [PATCH 5/7] HPET-RTC: disable interrupt when no longer needed
Message-ID: <20050928060306.A26313@unix-os.sc.intel.com>
References: <20050928071155.23025.43523.balrog@turing> <20050928071226.23025.56681.balrog@turing>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050928071226.23025.56681.balrog@turing>; from clemens@ladisch.de on Wed, Sep 28, 2005 at 09:12:26AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2005 at 09:12:26AM +0200, Clemens Ladisch wrote:
> When the emulated RTC interrupt is no longer needed, we better disable
> it; otherwise, we get a spurious interrupt whenever the timer has
> rolled over and reaches the same comparator value.
> 
> Having a superfluous interrupt every five minutes doesn't hurt much,
> but it's bad style anyway.  ;-)
> 

Do you really see the interrupt every five minutes once RTC is disabled.
Or is this to prevent a possible interrupt?
I had assumed while in one-shot interrupt mode, HPET would automatically unarm
after generating the interrupt, so that we won't get interrupts any more.

Thanks,
Venki

