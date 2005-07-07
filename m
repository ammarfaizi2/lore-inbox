Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbVGGInc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVGGInc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 04:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVGGIlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 04:41:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52400 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261243AbVGGIkn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 04:40:43 -0400
Date: Thu, 7 Jul 2005 01:40:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: P@draigBrady.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: How do you accurately determine a process' RAM usage?
Message-Id: <20050707014005.338ea657.akpm@osdl.org>
In-Reply-To: <42CCE737.70802@draigBrady.com>
References: <42CC2923.2030709@draigBrady.com>
	<20050706181623.3729d208.akpm@osdl.org>
	<42CCE737.70802@draigBrady.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

P@draigBrady.com wrote:
>
> Andrew Morton wrote:
> > Calculating this stuff accurately is very expensive.  You'll get a better
> > answer using proc-pid-smaps.patch from -mm, but even that won't tell you
> > things about sharing levels of the pages.
> 
> Great, thanks! I'll play around with this:
> http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc1/2.6.13-rc1-mm1/broken-out/proc-pid-smaps.patch

OK, please let us know how it goes.

> Looks like it's been stable for 4 months?

yup, although I don't think it's been used much.

> Given that it's an independent /proc/$pid/smaps file,
> it only needs to be queried when required and so
> I wouldn't worry too much about cost. `top` wouldn't use it
> for e.g., but specialised tools like mine would.

I agree, but people get upset ;)

Plus some userspace tool developer might see it and start using it without
knowing the cost on big iron.
