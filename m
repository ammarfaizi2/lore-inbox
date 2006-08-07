Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbWHGCnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbWHGCnr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 22:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbWHGCnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 22:43:47 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:54592 "EHLO
	asav02.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1750919AbWHGCnq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 22:43:46 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HAKJE1kSBUQ
From: Dmitry Torokhov <dtor@insightbb.com>
To: Andi Kleen <ak@muc.de>
Subject: Re: [PATCH] Turn rdmsr, rdtsc into inline functions, clarify names
Date: Sun, 6 Aug 2006 22:43:44 -0400
User-Agent: KMail/1.9.3
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
References: <1154771262.28257.38.camel@localhost.localdomain> <1154832963.29151.21.camel@localhost.localdomain> <20060806031643.GA43490@muc.de>
In-Reply-To: <20060806031643.GA43490@muc.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608062243.45129.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 August 2006 23:16, Andi Kleen wrote:
> This whole thing is broken, e.g. on a preemptive kernel when the
> code can switch CPUs 
> 

Would not preempt_disable fix that?

> Dmitry, I would suggest to convert it over to do_gettimeofday and remove
> all the architecture ifdefs.
> 
> Or maybe just remove it completely.  Who cares about the speed of a gameport 
> anyways? And why can't they measure it in user space? 
> 

Analog driver uses it to adjust timing. Vojtech should have more background
on that..

-- 
Dmitry
