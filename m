Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272201AbSISSdx>; Thu, 19 Sep 2002 14:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272258AbSISSdx>; Thu, 19 Sep 2002 14:33:53 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:61193 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S272201AbSISSdt>;
	Thu, 19 Sep 2002 14:33:49 -0400
Date: Thu, 19 Sep 2002 11:38:43 -0700
From: Greg KH <greg@kroah.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] In-kernel module loader 1/7
Message-ID: <20020919183843.GA16568@kroah.com>
References: <20020919125906.21DEA2C22A@lists.samba.org> <Pine.LNX.4.44.0209191532110.8911-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209191532110.8911-100000@serv>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2002 at 03:54:40PM +0200, Roman Zippel wrote:
> I already said often enough, a module has only to answer the simple
> question: Is it safe to unload the module?

And with a LSM module, how can it answer that?  There's no way, unless
we count every time someone calls into our module.  And if you do that,
no one will even want to use your module, given the number of hooks, and
the paths those hooks are on (the speed hit would be horrible.)

I'm with Rusty, just don't let people unload modules, unless you are
running a development kernel, and "obviously" know what you are doing.

thanks,

greg k-h
