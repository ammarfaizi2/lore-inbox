Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318929AbSIJBHl>; Mon, 9 Sep 2002 21:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318943AbSIJBHl>; Mon, 9 Sep 2002 21:07:41 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:25237 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318929AbSIJBHk>;
	Mon, 9 Sep 2002 21:07:40 -0400
Date: Mon, 9 Sep 2002 18:12:16 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: John Levon <movement@marcelothewonderpenguin.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.34 - EXPORT_SYMBOL(reparent_to_init) for module build
Message-ID: <20020909181216.A20508@eng2.beaverton.ibm.com>
References: <20020909172111.A19949@eng2.beaverton.ibm.com> <20020910002418.GA69537@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020910002418.GA69537@compsoc.man.ac.uk>; from movement@marcelothewonderpenguin.com on Tue, Sep 10, 2002 at 01:24:18AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2002 at 01:24:18AM +0100, John Levon wrote:
> On Mon, Sep 09, 2002 at 05:21:11PM -0700, Patrick Mansfield wrote:
> 
> > With 2.5.34, in order to build a module that calls daemonize(), I had to 
> > export reparent_to_init:
> 
> I suggest you check the source of daemonize() in 2.5.34 ;)
> 
> regards
> john

OK, thanks, I thought I grepped the module source (qla v6b5 adapter, not
included in the kernel tree), but missed the call to reparent_to_init().
I was wondering why I'd need an export for a function only called from
within in its own file. I removed the reparent_to_init call and it worked
fine.

Perhaps reparent_to_init should now be static?

Thanks.

-- Patrick Mansfield
