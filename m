Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbWF3Kcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbWF3Kcj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 06:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWF3Kcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 06:32:39 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:27275 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S932142AbWF3Kci (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 06:32:38 -0400
Date: Fri, 30 Jun 2006 03:24:35 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       perfmon@napali.hpl.hp.com
Subject: Re: perfmon2 vector argument question
Message-ID: <20060630102435.GA21819@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20060619204012.GE26378@frankl.hpl.hp.com> <20060628201708.08af034c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060628201708.08af034c.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

On Wed, Jun 28, 2006 at 08:17:08PM -0700, Andrew Morton wrote:
> > 
> > Does someone have something else to propose?
> > 
> > If not, what is your opinion of the two approaches above?
> > 
> 
> The first approach should be fine - we do that in lots of places, such as
> in core_sys_select().
> 
Ok, that's good to know. I looked at the stack consumption on x86 and it
is comparable to what you do for core_sys_select().

> Applications mut be calling this thing at a heck of a rate for kfree()
> overhead to matter.  I trust CONFIG_DEBUG_SLAB wasn't turned on...

That was using a micro-benchmark to stress certain paths in perfmon.
CONFIG_DEBUG_SLAB was not turned on.

Thanks.

-- 
-Stephane
