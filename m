Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263078AbTEMGFA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 02:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263084AbTEMGFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 02:05:00 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:57070 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S263078AbTEMGE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 02:04:59 -0400
Date: Mon, 12 May 2003 23:16:55 -0700
From: Chris Wright <chris@wirex.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, hch@infradead.org, greg@kroah.com,
       linux-security-module@wirex.com
Subject: Re: [PATCH] Early init for security modules
Message-ID: <20030512231655.B21486@figure1.int.wirex.com>
Mail-Followup-To: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
	hch@infradead.org, greg@kroah.com, linux-security-module@wirex.com
References: <20030512200309.C20068@figure1.int.wirex.com> <20030512201518.X19432@figure1.int.wirex.com> <20030513050336.GA10596@Wotan.suse.de> <20030512222000.A21486@figure1.int.wirex.com> <20030513052832.GF10596@Wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030513052832.GF10596@Wotan.suse.de>; from ak@suse.de on Tue, May 13, 2003 at 07:28:33AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen (ak@suse.de) wrote:
> On Mon, May 12, 2003 at 10:20:00PM -0700, Chris Wright wrote:
> > 
> > This is too late.  Those are just for order in do_initcalls() which is
> > well after some kernel threads have been created and filesystems have been
> > mounted, etc.  This patch allows statically linked modules to catch
> > the creation of such kernel objects and give them all consistent labels.
> 
> I would give them a generic name then in case someone else needs that too, 
> like "early_initcalls" 

I orginally thought it would be nice to make it generic, but it's
location is somewhat specific to the security hooks.  It seems there is
easily tension between conflicting needs, should be earlier...should be
later, so I made it specific.  Is there currently a need?

thanks,
chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
