Return-Path: <linux-kernel-owner+w=401wt.eu-S1762654AbWLKKwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762654AbWLKKwY (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 05:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762662AbWLKKwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 05:52:24 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:54089 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762654AbWLKKwX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 05:52:23 -0500
Date: Mon, 11 Dec 2006 10:52:19 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Olaf Hering <olaf@aepfle.de>
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] pipe: Don't oops when pipe filesystem isn't mounted
Message-ID: <20061211105219.GH4587@ftp.linux.org.uk>
References: <200612110436_MC3-1-D49E-FE59@compuserve.com> <20061211104857.GA16009@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061211104857.GA16009@aepfle.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2006 at 11:48:57AM +0100, Olaf Hering wrote:
> On Mon, Dec 11, Chuck Ebbert wrote:
> 
> > Why not create a new initcall category for things that must run before
> > early userspace?
> 
> Why do you want to continue with papering over the root cause?
> Pick some janitor, let him write something that implements something
> like make style dependencies for initcalls.
> Then you can get rid of all that foo_initcall stuff.
> It surely needs work to get all that done.

I would argue that _this_ is papering over the root cause.  Namely,
too complex ordering requirements.  Growing a technics for allowing
them to fester is an odd solution...
