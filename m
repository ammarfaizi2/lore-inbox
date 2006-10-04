Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbWJDTZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWJDTZj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 15:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbWJDTZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 15:25:39 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:60388 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1750872AbWJDTZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 15:25:38 -0400
Date: Wed, 4 Oct 2006 13:25:37 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Must check what?
Message-ID: <20061004192537.GH28596@parisc-linux.org>
References: <20061004183752.GG28596@parisc-linux.org> <20061004120242.319a47e4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061004120242.319a47e4.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 12:02:42PM -0700, Andrew Morton wrote:
> I blame kernel-doc.  It should have a slot for documenting the return value,
> but it doesn't, so nobody documents return values.

There's also the question about where the documentation should go.  By
the function prototype in the header?  That's the easy place for people
using the function to find it.  By the code?  That's the place where it
stands the most chance (about 10%) of somebody bothering to update it
when they change the code.

> It should have a slot for documenting caller-provided locking requirements
> too.  And for permissible calling-contexts.  They're all part of the
> caller-provided environment, and these two tend to be a heck of a lot more
> subtle than the function's formal arguments.

Indeed.  And reference count assumptions.  It's almost like we want a
pre-condition assertion ...
