Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270007AbTHCUpU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 16:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270032AbTHCUpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 16:45:20 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:20099 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S270007AbTHCUpR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 16:45:17 -0400
Date: Sun, 3 Aug 2003 22:45:16 +0200
From: bert hubert <ahu@ds9a.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, devik@cdi.cz
Subject: Re: [PATCH] Allow /dev/{,k}mem to be disabled to prevent kernel from being modified easily
Message-ID: <20030803204515.GA15271@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	devik@cdi.cz
References: <20030803180950.GA11575@outpost.ds9a.nl> <20030803123218.7bb2c16f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030803123218.7bb2c16f.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 03, 2003 at 12:32:18PM -0700, Andrew Morton wrote:
> bert hubert <ahu@ds9a.nl> wrote:
> >
> >  +#if defined(CONFIG_MEMORY_ACCESS)
> >   	{1, "mem",     S_IRUSR | S_IWUSR | S_IRGRP, &mem_fops},
> >   	{2, "kmem",    S_IRUSR | S_IWUSR | S_IRGRP, &kmem_fops},
> >  +#endif	
> 
> Well if you're going to do this, wouldn't it be better to force a segv and
> drop some messages in syslog?

problem with sigsegv is that it does not allow legitimate programs to choose
an alternate approach - the log entry would be nice though.

as one of the 'tastemasters', what are your thoughts on doing this
dynamically? The sigsegv option might be a dynamic option?

Thanks.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
