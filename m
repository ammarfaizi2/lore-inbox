Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285226AbSBRUFu>; Mon, 18 Feb 2002 15:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285093AbSBRUFk>; Mon, 18 Feb 2002 15:05:40 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:39430 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S284305AbSBRUFe>;
	Mon, 18 Feb 2002 15:05:34 -0500
Date: Mon, 18 Feb 2002 12:00:41 -0800
From: Greg KH <greg@kroah.com>
To: Patrik Weiskircher <me@justp.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: khubd zombie
Message-ID: <20020218200041.GE20284@kroah.com>
In-Reply-To: <1014039193.523.42.camel@dev1lap> <20020218181417.GA19992@kroah.com> <1014062182.608.36.camel@pat>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1014062182.608.36.camel@pat>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 21 Jan 2002 17:13:00 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2002 at 08:56:22PM +0100, Patrik Weiskircher wrote:
> 
> I tried it with 2.4.5, 2.4.12, 2.4.17.
> And I have to kill everything except init.
> I need a "clean" system.

What?  You want to also get rid of keventd, ksoftirqd_CPUX, kswapd, and
others and expect your machine to still work properly?

> Anyway, I don't think that it should behave like that.
> Killing something from userspace should not affect the kernel, or did I
> miss something?

This is a _kernel_ thread, not a userspace program running.

> I fixed it, it works, patch file attached.

And what happened to your USB devices when you kill khubd after applying
your patch?

The reparent_to_init() seems like the better thing to do.

thanks,

greg k-h
