Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262034AbSJQWES>; Thu, 17 Oct 2002 18:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262273AbSJQWER>; Thu, 17 Oct 2002 18:04:17 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:61198 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262034AbSJQWER>;
	Thu, 17 Oct 2002 18:04:17 -0400
Date: Thu, 17 Oct 2002 15:09:57 -0700
From: Greg KH <greg@kroah.com>
To: "David S. Miller" <davem@redhat.com>
Cc: hch@infradead.org, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
Message-ID: <20021017220956.GC1533@kroah.com>
References: <20021017203652.GB592@kroah.com> <20021017.133816.82029797.davem@redhat.com> <20021017205830.GD592@kroah.com> <20021017.135832.54206778.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021017.135832.54206778.davem@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 01:58:32PM -0700, David S. Miller wrote:
>    From: Greg KH <greg@kroah.com>
>    Date: Thu, 17 Oct 2002 13:58:31 -0700
> 
>    I've run the numbers myself on OSDL machines, and seen that there is no
>    measurable overhead for these functions.  Sure, there is an extra
>    function call, and different assembler, I'll never contest that.  It's
>    just that I could not measure it.
>    
> Did you look at the _code_?  Did you measure the size of even the
> non security/*.o object code with/without the hooks?  What is the
> added overhead?

I did not look at size, sorry.  I only looked at run-time performance.

> 2.5.x is busting at the seams currently and CONFIG_SECURITY is part of
> the reason why.

With the patch I just sent, that size issue should be resolved.

> I need to convince you to implement this in a way, so that like
> USB, there is zero overhead when I enable it as a module. :-)

I would love to implement it in such a manner.  Without using
self-modifying code, do you have any ideas of how this could be done?

thanks,

greg k-h
