Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752044AbWCOACU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbWCOACU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 19:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752053AbWCOACU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 19:02:20 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:10391
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1752044AbWCOACT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 19:02:19 -0500
Date: Tue, 14 Mar 2006 16:02:12 -0800
From: Greg KH <greg@kroah.com>
To: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Module Ref Counting & ibmphp
Message-ID: <20060315000212.GB6533@kroah.com>
References: <20060314224700.41242.qmail@web52612.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060314224700.41242.qmail@web52612.mail.yahoo.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2006 at 09:47:00AM +1100, Srihari Vijayaraghavan wrote:
> Before (in 2.6.16-rc*):
> $ egrep 'ibmphp' /proc/modules
> ibmphp 67809 4294967295 - Live 0xf8910000
>              ^^^^^^^^^^
> 
> After [1]:
> ibmphp 64224 0 - Live 0xf8965000
>              ^
> 
> Of course, now I'm able to successfully unload ibmphp
> (& subsequently load it too :)) without any
> observeable problems.
> 
> It'd seem, thro struct hotplug_slot_ops, module ref
> count for ibmphp is taken care of. No?

No.  I don't think this driver likes to be unloaded due to the
instability of the hardware if that happens.  So let's just let it not
be unloaded, and hope that the hardware can die in peace and never get
put into any new machines...

thanks,

greg k-h
