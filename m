Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291464AbSBAAtT>; Thu, 31 Jan 2002 19:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291465AbSBAAtJ>; Thu, 31 Jan 2002 19:49:09 -0500
Received: from www.transvirtual.com ([206.14.214.140]:15379 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S291464AbSBAAsw>; Thu, 31 Jan 2002 19:48:52 -0500
Date: Thu, 31 Jan 2002 16:48:07 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Wartan Hachaturow <wart@softhome.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Console driver behaviour?
In-Reply-To: <20020130162536.GA12421@mojo.spb.ru>
Message-ID: <Pine.LNX.4.10.10201311644090.6830-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> How can I determine that the program is run via ssh or on
> a headless box?

Hm. I never seen a clean way to do this :-( 

> The problem is with Linux Console Tools. It tries opening 
> /dev/tty, /dev/tty0 and /dev/console respectively upon the 
> start, and it fails on ssh'ed or headless boxes. Is there 
> any way to catch the situation? I've thought that open should
> return ENODEV in these cases, but it doesn't..

/dev/console -> System console. printk messages are sent to these devices.
 		It is always there.

/dev/tty     -> The TTY device associated with the current process 

/dev/tty0    -> Only related to VTs. This is the foreground virtual 
		termial (made from a graphics card and a regular keyboard)

