Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265558AbSKAA7P>; Thu, 31 Oct 2002 19:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265559AbSKAA7O>; Thu, 31 Oct 2002 19:59:14 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:29715 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265558AbSKAA7O>;
	Thu, 31 Oct 2002 19:59:14 -0500
Date: Thu, 31 Oct 2002 17:02:41 -0800
From: Greg KH <greg@kroah.com>
To: "Lee, Jung-Ik" <jung-ik.lee@intel.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: RFC: bare pci configuration access functions ?
Message-ID: <20021101010241.GE12405@kroah.com>
References: <72B3FD82E303D611BD0100508BB29735046DFF69@orsmsx102.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72B3FD82E303D611BD0100508BB29735046DFF69@orsmsx102.jf.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wait, first off, are we talking about 2.4, or 2.5 here?  For 2.5 I think
everything is covered, right?

On Thu, Oct 31, 2002 at 11:29:19AM -0800, Lee, Jung-Ik wrote:
> Question:
> ========
> Will it be desirable to have bare global pci config access functions as seen
> in i386/ia64 pci codes ? It's clean and needs just what it takes - seg, bus,
> dev, func, where, value, and size.

No, I do not think so.  I think the way 2.5 does this is the correct
way.  But as I did that patch, I might be a bit biased :)

We could just force every arch to export the same functions that i386
and ia64 does, that shouldn't be a big deal.  I think this would solve
the problem on 2.4 for pci hotplug, as ACPI is already "cheating" and
doing this right now...

thanks,

greg k-h
