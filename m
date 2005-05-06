Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261790AbVEFAvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbVEFAvc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 20:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbVEFAvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 20:51:32 -0400
Received: from fmr24.intel.com ([143.183.121.16]:33765 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261790AbVEFAva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 20:51:30 -0400
Date: Thu, 5 May 2005 17:51:00 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, zwane@arm.linux.org.uk, shaohua.li@intel.com
Subject: Re: make smp_prepare_cpu to a weak function
Message-ID: <20050505175059.A18081@unix-os.sc.intel.com>
References: <20050505170727.A17919@unix-os.sc.intel.com> <1115340027.6503.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1115340027.6503.1.camel@localhost.localdomain>; from arjan@infradead.org on Thu, May 05, 2005 at 08:40:27PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2005 at 08:40:27PM -0400, Arjan van de Ven wrote:
> On Thu, 2005-05-05 at 17:07 -0700, Ashok Raj wrote:
> > +int __attribute__((weak)) smp_prepare_cpu (int cpu)
> > +{
> > +	return 0;
> > +}
> 
> 
> ehhh what does this attribute mean here?????
> 
> 

This function exists only for i386. Today for smp suspend they are using
cpu hotplug code, but since i386 startup code is not like
true smp bringup, so there is this hack to prepare something before calling
__cpu_up().

This is just to provide a default implementation, in the case arch
doesnt provide a smp_prepare_cpu(). 

Hope i answered the right question, unless you have something subtle here :-(

Cheers,
ashok
-- 
Cheers,
Ashok Raj
- Open Source Technology Center
