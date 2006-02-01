Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422977AbWBAWQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422977AbWBAWQe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 17:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422979AbWBAWQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 17:16:34 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:2786 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1422977AbWBAWQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 17:16:33 -0500
Subject: Re: 2.6.15-rt16
From: Steven Rostedt <rostedt@goodmis.org>
To: Clark Williams <williams@redhat.com>
Cc: chris perkins <cperkins@OCF.Berkeley.EDU>, linux-kernel@vger.kernel.org
In-Reply-To: <1138830694.18762.46.camel@localhost.localdomain>
References: <Pine.SOL.4.63.0601300839050.8546@conquest.OCF.Berkeley.EDU>
	 <1138640592.12625.0.camel@localhost.localdomain>
	 <Pine.SOL.4.63.0601300917120.8546@conquest.OCF.Berkeley.EDU>
	 <1138653235.26657.7.camel@localhost.localdomain>
	 <Pine.SOL.4.63.0601310946000.8770@conquest.OCF.Berkeley.EDU>
	 <1138730835.5959.3.camel@localhost.localdomain>
	 <1138818770.6685.1.camel@localhost.localdomain>
	 <1138819142.18762.10.camel@localhost.localdomain>
	 <1138830476.6632.5.camel@localhost.localdomain>
	 <1138830694.18762.46.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 01 Feb 2006 17:16:19 -0500
Message-Id: <1138832179.6632.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-01 at 15:51 -0600, Clark Williams wrote:

> > Could you make sure that your modules in the initrd that you use are the
> > ones created with the LATENCY_TRACE option.  After converting all the
> > modules into compiled in options, I successfully booted the kernel.  So
> > you might have an incompatibility with the modules in initrd, when you
> > turn on LATENCY_TRACE.
> 
> Did you ever duplicated the failure?

No, but I don't use an initrd, so my failure was first that it couldn't
recognize my harddrives.  So I compiled in the necessary drivers into my
kernel, and it booted right up to the GDM login.  I logged in, and was
going to reply to you, but I guess I have a different network card since
I had no network.

> 
> I'm fairly certain that the initrd contains the appropriate modules,
> since I regenerate the initrd each time I generate a new kernel, but
> I'll go back and verify. 
> 
> I'll also convert modules to compiled in and see if that makes a
> difference.

Thanks, I've been burnt before with incompatible modules in initrd, that
I now only use compiled in modules that are needed to boot (ide, ext3,
etc).  When compiling 3 different kernels with several different configs
constantly for the same machine, it just becomes easier to not use an
initrd.

-- Steve


