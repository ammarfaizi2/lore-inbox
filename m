Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbWHGIsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWHGIsw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 04:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWHGIsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 04:48:52 -0400
Received: from colin.muc.de ([193.149.48.1]:8714 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1751158AbWHGIsw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 04:48:52 -0400
Date: 7 Aug 2006 10:48:50 +0200
Date: Mon, 7 Aug 2006 10:48:50 +0200
From: Andi Kleen <ak@muc.de>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] Turn rdmsr, rdtsc into inline functions, clarify names
Message-ID: <20060807084850.GA67713@muc.de>
References: <1154771262.28257.38.camel@localhost.localdomain> <1154832963.29151.21.camel@localhost.localdomain> <20060806031643.GA43490@muc.de> <200608062243.45129.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608062243.45129.dtor@insightbb.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 06, 2006 at 10:43:44PM -0400, Dmitry Torokhov wrote:
> On Saturday 05 August 2006 23:16, Andi Kleen wrote:
> > This whole thing is broken, e.g. on a preemptive kernel when the
> > code can switch CPUs 
> > 
> 
> Would not preempt_disable fix that?

Partially, but you still have other problems. Please just get rid
of it. Why do we have timer code in the kernel if you then chose
not to use it?

-Andi
