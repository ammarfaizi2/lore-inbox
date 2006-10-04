Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbWJDTCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWJDTCr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 15:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWJDTCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 15:02:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38354 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750806AbWJDTCp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 15:02:45 -0400
Date: Wed, 4 Oct 2006 12:02:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Must check what?
Message-Id: <20061004120242.319a47e4.akpm@osdl.org>
In-Reply-To: <20061004183752.GG28596@parisc-linux.org>
References: <20061004183752.GG28596@parisc-linux.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Oct 2006 12:37:53 -0600
Matthew Wilcox <matthew@wil.cx> wrote:

> 
> I'd like to propose that anyone adding __must_check markers in the
> future be forced to *WRITE SOME FUCKING DOCUMENTATION* about exactly
> what it is the caller is supposed to be checking.
> 
> extern int __must_check bus_register(struct bus_type * bus);
> 

I blame kernel-doc.  It should have a slot for documenting the return value,
but it doesn't, so nobody documents return values.

It should have a slot for documenting caller-provided locking requirements
too.  And for permissible calling-contexts.  They're all part of the
caller-provided environment, and these two tend to be a heck of a lot more
subtle than the function's formal arguments.

> Why, thank you.  Does it return 0 for success, or 1 on success?  Does it
> return an errno?

yes, no, yes ;)
