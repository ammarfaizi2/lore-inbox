Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265085AbSJRMoF>; Fri, 18 Oct 2002 08:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265088AbSJRMoF>; Fri, 18 Oct 2002 08:44:05 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:60427 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265085AbSJRMoE>; Fri, 18 Oct 2002 08:44:04 -0400
Date: Fri, 18 Oct 2002 13:50:01 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Crispin Cowan <crispin@wirex.com>
Cc: Greg KH <greg@kroah.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
Message-ID: <20021018135001.A1670@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Crispin Cowan <crispin@wirex.com>, Greg KH <greg@kroah.com>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org,
	linux-security-module@wirex.com
References: <20021017195015.A4747@infradead.org> <20021017185352.GA32537@kroah.com> <20021017195838.A5325@infradead.org> <20021017190723.GB32537@kroah.com> <20021017210402.A7741@infradead.org> <20021017201030.GA384@kroah.com> <20021017211223.A8095@infradead.org> <3DAFB260.5000206@wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DAFB260.5000206@wirex.com>; from crispin@wirex.com on Fri, Oct 18, 2002 at 12:04:00AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 12:04:00AM -0700, Crispin Cowan wrote:
> >I know.  but hiding them doesn't make them any better..
> >
> Actuall, yes it does, and that is the point. You don't have to like 
> SELinux's system calls, or any other module's syscalls. The whole point 
> of LSM was to decouple security design from the Linux kernel development.

But I dislike the notation of module syscalls.  Syscalls are a global
thing and they shall not be registered without proper review from
all kernel developers.  Driver development is untangled from kernel
development, too and it doesn;t need syscalls.

> There are a butt-load of different access control models, and many of 
> them are not compatible with one another. You wouldn't want to support 
> them all--that would be serious bloat. So instead, LSM lets each user 
> choose the model that suits them:

Fucking no!  Don't add syscall interfaces without review.  Adding
a new syscall for a "security modules" is sign that you got
your design wrong.

>     * server users can choose a highly secure model
>     * workstation users can choose something desktop oriented
>     * embedded people can choose nothing at all, or the specific
>       narrow-cast model that they need

Blah, blah, blah.  You don't get more security by pluggin in a buggy
module.

> On the other hand: what is the big cost here? One system call. Isn't 
> that actually *lower* overhead than the (say) half dozen 
> security-oriented syscalls we might convince you to accept if we drop 
> the sys_security syscall as you suggest? Why the fierce desire to remove 
> something so cheap?

It's the broken design.  Look at windows:  it has tons of cheap
features - and exactly because of that it's such a piece of crap.

