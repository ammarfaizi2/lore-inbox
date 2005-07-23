Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbVGWQFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbVGWQFy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 12:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbVGWQFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 12:05:53 -0400
Received: from [69.25.196.29] ([69.25.196.29]:42147 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261756AbVGWQFv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 12:05:51 -0400
Date: Sat, 23 Jul 2005 11:25:46 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Amit S. Kale" <amitkale@linsyssoft.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: CheckFS: Checkpoints and Block Level Incremental Backup (BLIB)
Message-ID: <20050723152546.GA15218@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	"Amit S. Kale" <amitkale@linsyssoft.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <200507231130.07208.amitkale@linsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507231130.07208.amitkale@linsyssoft.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 23, 2005 at 11:30:07AM +0530, Amit S. Kale wrote:
> 
> We started it from 2.6.7 last year and then it was sitting idle for several 
> months for lack of resources. We'll go back to that version and generate a 
> diff that's easier to read.
> 
> Yes, changing the name has made the task of rebasing wrt. changing kernels lot 
> difficult. Our original intention was to make testing easier by keeping ext3 
> and checkfs filesystems in the same kernel. Had we continued it at that 
> point, we would have posted differences wrt. ext3 sources themselves. There 
> was compelling reason to change the name.

One easier way of doing development, particularly for people doing
filesystem work, is to compile the kernel with the test filesystem
code using user-mode linux (UML) architecture.  This significantly
shortens your edit-compile-debug cycle time, and it makes it easier to
run your filesystem code under a debugger.  That way you also don't
have to worry about your filesystem changes toasting your system,
either.  This technique doesn't work all that well for people doing
architecture-specific code or for device drivers, but for filesystems,
it's ideal.

Regards,

						- Ted
