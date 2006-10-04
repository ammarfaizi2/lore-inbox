Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750925AbWJDTtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbWJDTtX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 15:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWJDTtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 15:49:23 -0400
Received: from xenotime.net ([66.160.160.81]:45721 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750919AbWJDTtW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 15:49:22 -0400
Date: Wed, 4 Oct 2006 12:50:47 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Must check what?
Message-Id: <20061004125047.2c608dde.rdunlap@xenotime.net>
In-Reply-To: <20061004192537.GH28596@parisc-linux.org>
References: <20061004183752.GG28596@parisc-linux.org>
	<20061004120242.319a47e4.akpm@osdl.org>
	<20061004192537.GH28596@parisc-linux.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Oct 2006 13:25:37 -0600 Matthew Wilcox wrote:

> On Wed, Oct 04, 2006 at 12:02:42PM -0700, Andrew Morton wrote:
> > I blame kernel-doc.  It should have a slot for documenting the return value,
> > but it doesn't, so nobody documents return values.

Anyone can add what kernel-doc sees as a section.  Just use:

 * Returns:
 * and describe the return values.

> There's also the question about where the documentation should go.  By
> the function prototype in the header?  That's the easy place for people
> using the function to find it.  By the code?  That's the place where it
> stands the most chance (about 10%) of somebody bothering to update it
> when they change the code.

Good questions.  Jury is still out, I suppose.

> > It should have a slot for documenting caller-provided locking requirements
> > too.  And for permissible calling-contexts.  They're all part of the
> > caller-provided environment, and these two tend to be a heck of a lot more
> > subtle than the function's formal arguments.
> 
> Indeed.  And reference count assumptions.  It's almost like we want a
> pre-condition assertion ...

I want context documentation:
 * Context:
 * Interrupt or process or bh/softirq etc. (or Any)


---
~Randy
