Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbUENTgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUENTgQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 15:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbUENTgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 15:36:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:16535 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262328AbUENTgP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 15:36:15 -0400
Date: Fri, 14 May 2004 12:36:12 -0700
From: Chris Wright <chrisw@osdl.org>
To: "Kevin O'Connor" <kevin@koconnor.net>
Cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       hch@infradead.org, linux-kernel@vger.kernel.org,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.6.6-mm2
Message-ID: <20040514123612.W21045@build.pdx.osdl.net>
References: <20040513032736.40651f8e.akpm@osdl.org> <20040513114520.A8442@infradead.org> <20040513035134.2e9013ea.akpm@osdl.org> <20040513121850.B22989@build.pdx.osdl.net> <20040513123809.01398f93.akpm@osdl.org> <20040514190642.GA6333@ohio.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040514190642.GA6333@ohio.localdomain>; from kevin@koconnor.net on Fri, May 14, 2004 at 03:06:42PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Kevin O'Connor (kevin@koconnor.net) wrote:
> On Thu, May 13, 2004 at 12:38:09PM -0700, Andrew Morton wrote:
> > Chris Wright <chrisw@osdl.org> wrote:
> > >
> > > 
> > >  +static int capability_mask;
> > >  +module_param_named(mask, capability_mask, int, 0);
> > >  +MODULE_PARM_DESC(mask, "Mask of capability checks to ignore");
> > 
> > Is there a way to make this tunable at runtime, btw?
> 
> I thought that was what the fourth argument to module_param_named was for..
> 
> 
> /* This is the fundamental function for registering boot/module
>    parameters.  perm sets the visibility in driverfs: 000 means it's
>    not there, read bits mean it's readable, write bits mean it's
>    writable. */
> #define __module_param_call(prefix, name, set, get, arg, perm)          \
> 
> Did I miss something?

No, that's right, but I didn't think it was safe enough, because it
doesn't let you register your own function to manage how the variable is
set.  For example, only clearing set bits.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
