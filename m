Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263407AbTETAq1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 20:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263408AbTETAq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 20:46:27 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:28413 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S263407AbTETAqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 20:46:25 -0400
Date: Mon, 19 May 2003 17:57:44 -0700
From: Chris Wright <chris@wirex.com>
To: Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, greg@kroah.com,
       linux-security-module@wirex.com
Subject: Re: [PATCH] Early init for security modules
Message-ID: <20030519175744.K13200@figure1.int.wirex.com>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
	greg@kroah.com, linux-security-module@wirex.com
References: <20030512200309.C20068@figure1.int.wirex.com> <20030512201518.X19432@figure1.int.wirex.com> <20030513050336.GA10596@Wotan.suse.de> <20030512222000.A21486@figure1.int.wirex.com> <20030513062748.A2677@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030513062748.A2677@infradead.org>; from hch@infradead.org on Tue, May 13, 2003 at 06:27:48AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Christoph Hellwig (hch@infradead.org) wrote:
> On Mon, May 12, 2003 at 10:20:00PM -0700, Chris Wright wrote:
> > This is too late.  Those are just for order in do_initcalls() which is
> > well after some kernel threads have been created and filesystems have been
> > mounted, etc.  This patch allows statically linked modules to catch
> > the creation of such kernel objects and give them all consistent labels.
> 
> Patch looks fine to me.  Could you please make the initcalls mandatory
> for security modules and remove the module exports for the regioster
> functions so peop can't do the crappy check for each module whether it's
> already initialized stuff the early selinux for LSM versions did?

I absolutely agree the preconditions aren't nice, but not all security modules
need them.  I don't think disabling dynamic loading needs to be a
requirement for the initcall.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
