Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbUENTG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbUENTG4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 15:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUENTG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 15:06:56 -0400
Received: from sitemail2.everyone.net ([216.200.145.36]:32962 "EHLO
	omta10.mta.everyone.net") by vger.kernel.org with ESMTP
	id S262006AbUENTGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 15:06:54 -0400
X-Eon-Sig: AQHOS7NApRjGY6xawgIAAAAF,cadc4c427e3e6bfa45ab0753fdb4c29f
Date: Fri, 14 May 2004 15:06:42 -0400
From: "Kevin O'Connor" <kevin@koconnor.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wright <chrisw@osdl.org>, hch@infradead.org,
       linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.6.6-mm2
Message-ID: <20040514190642.GA6333@ohio.localdomain>
References: <20040513032736.40651f8e.akpm@osdl.org> <20040513114520.A8442@infradead.org> <20040513035134.2e9013ea.akpm@osdl.org> <20040513121850.B22989@build.pdx.osdl.net> <20040513123809.01398f93.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040513123809.01398f93.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2004 at 12:38:09PM -0700, Andrew Morton wrote:
> Chris Wright <chrisw@osdl.org> wrote:
> >
> > 
> >  +static int capability_mask;
> >  +module_param_named(mask, capability_mask, int, 0);
> >  +MODULE_PARM_DESC(mask, "Mask of capability checks to ignore");
> 
> Is there a way to make this tunable at runtime, btw?

I thought that was what the fourth argument to module_param_named was for..


/* This is the fundamental function for registering boot/module
   parameters.  perm sets the visibility in driverfs: 000 means it's
   not there, read bits mean it's readable, write bits mean it's
   writable. */
#define __module_param_call(prefix, name, set, get, arg, perm)          \


Did I miss something?

-Kevin
