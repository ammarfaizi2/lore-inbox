Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291462AbSBAApT>; Thu, 31 Jan 2002 19:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291463AbSBAApH>; Thu, 31 Jan 2002 19:45:07 -0500
Received: from www.transvirtual.com ([206.14.214.140]:13587 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S291462AbSBAAox>; Thu, 31 Jan 2002 19:44:53 -0500
Date: Thu, 31 Jan 2002 16:43:53 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Wartan Hachaturow <wart@softhome.net>
cc: Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
Subject: Re: Console driver behaviour?
In-Reply-To: <20020130235702.A23358@penguin.aktivist.ru>
Message-ID: <Pine.LNX.4.10.10201311641470.6830-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > any way to catch the situation? I've thought that open should
> > > return ENODEV in these cases, but it doesn't..
> > 
> > screen, perhaps?  this is most definitely not a linux-kernel question.
> 
> This is most probably a console driver question, which is
> kernel-specific ;)
> I wonder what should console driver say when it doesn't have a real physical
> console behind it. IMO, this should be a ENODEV case, or some other way
> to determine programmatically that this situation takes place.

That should not happen. Especially since int init/main.c we have:

if (open("/dev/console", O_RDWR, 0) < 0)
                printk("Warning: unable to open an initial console.\n");

(void) dup(0);
(void) dup(0);

which causes alot of problems. 

> So, I am trying to find someone familar with console driver on
> linux-kernel (since this driver doesn't have a specific maintainer).

That would be me :-/

