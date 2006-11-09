Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424209AbWKIWls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424209AbWKIWls (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 17:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966062AbWKIWls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 17:41:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58240 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S966017AbWKIWls (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 17:41:48 -0500
Date: Thu, 9 Nov 2006 14:41:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent an oops in vmalloc_user()
Message-Id: <20061109144143.11fbca6d.akpm@osdl.org>
In-Reply-To: <4553ABCE.2050006@cosmosbay.com>
References: <31360.1163109619@lwn.net>
	<4553ABCE.2050006@cosmosbay.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Nov 2006 23:29:34 +0100
Eric Dumazet <dada1@cosmosbay.com> wrote:

> Jonathan Corbet a __crit :
> > Prevent an oops in vmalloc_user()
> > 
> > If an attempt to allocate memory with vmalloc_user() fails, the result
> > will be an oops when it tries to tweak the flags in the (non-existent)
> > VMA.  One could argue that __find_vm_area() should not return a random
> > pointer on failure, but vmalloc_user() requires a check regardless.
> > 
> 
> Yes, I already posted a patch for that, and other problem as well.
> 
> http://lkml.org/lkml/2006/10/23/86
> 
> Maybe it was lost...
> 

It's in -mm but I'd queued it for 2.6.20 because you went and mixed a bunch
of things into the same patch.

Whatever - I'll push it for 2.6.19.
