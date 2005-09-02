Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030658AbVIBCae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030658AbVIBCae (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 22:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030659AbVIBCae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 22:30:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64979 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030658AbVIBCad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 22:30:33 -0400
Date: Thu, 1 Sep 2005 19:28:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: hyoshiok@miraclelinux.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
Message-Id: <20050901192840.0406862e.akpm@osdl.org>
In-Reply-To: <200509020417.10574.ak@suse.de>
References: <20050825.135420.640917643.hyoshiok@miraclelinux.com>
	<20050902.104359.26944961.hyoshiok@miraclelinux.com>
	<20050901190846.479229cf.akpm@osdl.org>
	<200509020417.10574.ak@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> On Friday 02 September 2005 04:08, Andrew Morton wrote:
> 
> > I suppose I'll queue it up in -mm for a while, although I'm a bit dubious
> > about the whole idea...  We'll gain some and we'll lose some - how do we
> > know it's a net gain?
> 
> I suspect it'll gain more than it loses. The only case where it might 
> not gain is immediately someone reading the data from the page cache again
> after the write.

That's a pretty common case - temporary files.

> But I suppose that's far less frequent than writing the data.

yup.

Hiro, could you please send through a summary of the performance testing
results sometime?  Runtimes rather than oprofile output?
