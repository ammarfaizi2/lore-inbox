Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265154AbUELSHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265154AbUELSHs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 14:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265150AbUELSHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 14:07:00 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:33287 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265152AbUELSFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 14:05:05 -0400
Date: Wed, 12 May 2004 19:04:54 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: David Mosberger-Tang <davidm@hpl.hp.com>, linux-ia64@linuxia64.org,
       linux-kernel@vger.kernel.org
Subject: Re: GCC nested functions?
Message-ID: <20040512190454.A31410@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephen Hemminger <shemminger@osdl.org>,
	David Mosberger-Tang <davidm@hpl.hp.com>, linux-ia64@linuxia64.org,
	linux-kernel@vger.kernel.org
References: <20040512105924.54a8211b@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040512105924.54a8211b@dell_ss3.pdx.osdl.net>; from shemminger@osdl.org on Wed, May 12, 2004 at 10:59:24AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2004 at 10:59:24AM -0700, Stephen Hemminger wrote:
> Redoing it as separate functions is easy enough, but the questions are:
> 	- Are gcc nested functions allowed in the kernel?  If not where should
> 	  this restriction be put in Documentation? CodingStyles?

nested function are a horrible gcc misfeature.  So far people had enough
taste to not introduce them without explicitly forbidding it ;-)

Maybe we should add a section to Documentation/CodingStyles that says
which gcc extensions are okay for kernel use.

> 	- Or is gcc on ia64 just too stupid? or do some more support routines
> 	  need to exist in arch/ia64?
> 	- Do other architectures (sparc, ppc) have similar problems?

There's a few architectures needing libgcc help for trampolines, but I
don't remember which ones exactly.

