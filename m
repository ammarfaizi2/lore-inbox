Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269107AbUHXXIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269107AbUHXXIv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 19:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269098AbUHXXIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 19:08:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:39146 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269115AbUHXXFt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 19:05:49 -0400
Date: Tue, 24 Aug 2004 16:04:58 -0700
From: Greg KH <greg@kroah.com>
To: "Nemosoft Unv." <nemosoft@smcc.demon.nl>
Cc: Linux USB Mailing List <linux-usb-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.8 pwc patches and counterpatches
Message-ID: <20040824230458.GA12422@kroah.com>
References: <1092793392.17286.75.camel@localhost> <1092845135.8044.22.camel@localhost> <20040823221028.GB4694@kroah.com> <200408250058.24845@smcc.demon.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408250058.24845@smcc.demon.nl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 12:58:24AM +0200, Nemosoft Unv. wrote:
> Anyway....
> 
> I've just about had it with the increasing 
> "we-don't-want-binary-stuff-in-Linux" attitude lately. If you rip out this 
> hook for PWC (pwc_register_decompressor), which would make it impossible to 
> load a decompressor, closed source *OR* open source (should that happen one 
> day), is going to be the last straw.

Well, I just made a patch that did just that, and applied it to my
trees.

> Without this hook, PWC will work, but with limitations, just as it always 
> has. But the _user_ always had a choice of loading a closed source module 
> to get the extras. If you, kernel developers, maintainers, etc. are going 
> to take away that right from the _users_, I think you're way over head, 
> forgetting what open source is about, IMO.
> 
> I accept that the Linux kernel is the work of Linus and the maintainers, and 
> they can do with it as they please, but I will not accept that they can put 
> arbitrary limits on the kernel's use by me, or other users.

Think legal limits, not arbitrary.

> Anyway, before this gets too long... I'm giving you a choice here. Either:
> 
> * you are going to accept that there is a driver in the Linux kernel that 
> has a hook that _may_ be used to load a binary-only decompressor part into 
> the kernel, at the user's disgression. Maybe, one day, that part will be 
> open source too but I cannot guarantuee that. 

I now realize that.  So I've ripped that hook out, as it's only used to
load a binary driver, which is not allowed.

That's the change I'm going to make.

If you want to send me a patch to tell me to rip the whole driver out,
fine I will, no problems, I completly understand.

But realize that anyone can then add it back, as the work you did was
released under the GPL :)

thanks,

greg k-h
