Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262244AbUKWHaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262244AbUKWHaG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 02:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262302AbUKWHaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 02:30:06 -0500
Received: from mail.kroah.org ([69.55.234.183]:39386 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262244AbUKWH35 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 02:29:57 -0500
Date: Mon, 22 Nov 2004 23:29:45 -0800
From: Greg KH <greg@kroah.com>
To: Roland Dreier <roland@topspin.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC/v1][4/12] Add InfiniBand SA (Subnet Administration) query support
Message-ID: <20041123072944.GA22786@kroah.com>
References: <20041122713.SDrx8l5Z4XR5FsjB@topspin.com> <20041122713.g6bh6aqdXIN4RJYR@topspin.com> <20041122222507.GB15634@kroah.com> <527jodbgqo.fsf@topspin.com> <20041123064120.GB22493@kroah.com> <52hdnh83jy.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52hdnh83jy.fsf@topspin.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 10:47:29PM -0800, Roland Dreier wrote:
>     Greg> Yeah, but a name in each file is much nicer.
> 
> Very little of the kernel seems to follow this rule right now.

I agree, but it's good to add this for new files.

>     Greg> One comment, the file drivers/infiniband/core/cache.c has a
>     Greg> license that is illegal due to the contents of the file.
>     Greg> Please change the license of the file to GPL only.
> 
> ?? Can you explain this?  What makes that file special?

You are using a specific data structure that is only licensed to be used
in GPL code.  By using it in code that has a non-GPL license (like the
dual license you have) you are violating the license of that code, and
open yourself up to lawsuits by the holder of that code.

There, can I be vague enough?  :)

To be straightforward, either drop the RCU code completely, or change
the license of your code.  

Hm, because of the fact that you are linking in GPL only code into this
code (because of the .h files you are using) how could you ever expect
to use a BSD-like license for this collected work?

Aren't licenses fun...

thanks,

greg k-h

