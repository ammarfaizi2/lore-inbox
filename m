Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbUKFAsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbUKFAsa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 19:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbUKFAsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 19:48:30 -0500
Received: from mail.kroah.org ([69.55.234.183]:31897 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261280AbUKFAsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 19:48:23 -0500
Date: Fri, 5 Nov 2004 16:47:57 -0800
From: Greg KH <greg@kroah.com>
To: Robert Love <rml@novell.com>
Cc: John McCutchan <ttb@tentacle.dhs.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] inotify: add FIONREAD support
Message-ID: <20041106004755.GA23981@kroah.com>
References: <1099696444.6034.266.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099696444.6034.266.camel@localhost>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 06:14:04PM -0500, Robert Love wrote:
> John,
> 
> There are a handful of "standard" file ioctl's (FIBMAP, FIONREAD,
> FIGETBSZ, etc.).  We don't have to implement any of them, but FIONREAD
> is actually pretty useful: It tells you how many bytes are available on
> the fd.

Nice idea.

> +	case FIONREAD:
> +		bytes = dev->event_count * sizeof (struct inotify_event);
> +		return put_user(bytes, (int *) p);

But sparse will spit out warnings with code like this :(

Actually, the whole inotify patch probably isn't sparse clean...

thanks,

greg k-h
