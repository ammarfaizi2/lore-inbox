Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261693AbSJQRQJ>; Thu, 17 Oct 2002 13:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261688AbSJQRPT>; Thu, 17 Oct 2002 13:15:19 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:6670 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261536AbSJQROY>;
	Thu, 17 Oct 2002 13:14:24 -0400
Date: Thu, 17 Oct 2002 10:20:05 -0700
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@infradead.org>, Crispin Cowan <crispin@wirex.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make LSM register functions GPLonly exports
Message-ID: <20021017172005.GE31464@kroah.com>
References: <20021017175403.A32516@infradead.org> <Pine.LNX.4.44.0210170958340.6739-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210170958340.6739-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 10:08:19AM -0700, Linus Torvalds wrote:
> 
> Note that if this fight ends up being a major issue, I'm just going to 
> remove LSM and let the security vendors do their own thing. So far
> 
>  - I have not seen a lot of actual usage of the hooks

The SELinux module uses almost every hook so far.  A number of companies
and distros are currently auditing this module, and it will probably be
submitted for inclusion into the main kernel tree after they are
finished.

>  - seen a number of people who still worry that the hooks degrade 
>    performance in critical areas

I have a set of patches to send you today that will solve that problem,
by allowing people who do not want the hook to compile them away into
nothingness.  DaveM agrees with the proposed way of doing this.

>  - the worry that people use it for non-GPL'd modules is apparently real, 
>    considering Crispin's reply.

I agree with this, and argue to mark the functions as
EXPORT_SYMBOL_GPL() to make some people feel a bit more warm and fuzzy
that these hooks will not be co-oped for non-GPL use (this includes me.)

In short, I like Christoph's patch.

> I will re-iterate my stance on the GPL and kernel modules:

Thank you for posting this.  I know a lot of people appreciate it.

greg k-h
