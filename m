Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbTFJWtL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 18:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbTFJWtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 18:49:11 -0400
Received: from air-2.osdl.org ([65.172.181.6]:26837 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261564AbTFJWtI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 18:49:08 -0400
Date: Tue, 10 Jun 2003 16:03:18 -0700
From: Dave Olien <dmo@osdl.org>
To: Steven Cole <elenstev@mesatop.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparse type checking on function pointers
Message-ID: <20030610230318.GA10106@osdl.org>
References: <20030610212404.GA25410@osdl.org> <1055284400.2269.56.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055284400.2269.56.camel@spc9.esa.lanl.gov>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 10, 2003 at 04:33:20PM -0600, Steven Cole wrote:
>
> That reduced the number of that kind of warning significantly.
> 

Thanks! I'm still kind of groping my way through the code, fixing
these warnings as a motivator to keep me working my way through it.

> 
> Now, if only Linus would change this:
> 
> CHECK           = /home/torvalds/parser/check
> 
> to something more reasonable like
> 
> CHECK           = /usr/local/bin/check
> 
> Steven
> 

I assume Linus has done this because the sparse library is still
a prototype, and the "check" binary is not really the intended end point
but just a simple front-end to invoke the library to test it.

I find it really easy to just over-ride this on the make command line:

	make CHECK=/dmo_local/BK_TREES/sparse_original/check C=1

This makes it easy for me to test different versions of the library as
I'm making modifications either to fix a problem, or to put debug statements
into the source code to undestand it.

Combine this with a good shell that supports history editing, and it's
not really a big problem.

Dave
