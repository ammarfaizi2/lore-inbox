Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265053AbSKFNYY>; Wed, 6 Nov 2002 08:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265050AbSKFNYY>; Wed, 6 Nov 2002 08:24:24 -0500
Received: from smtp1.texas.rr.com ([24.93.36.229]:36080 "EHLO
	txsmtp01.texas.rr.com") by vger.kernel.org with ESMTP
	id <S265049AbSKFNYW>; Wed, 6 Nov 2002 08:24:22 -0500
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <kcorry@austin.rr.com>
Reply-To: kcorry@austin.rr.com
To: Mike Diehl <mdiehl@dominion.dyndns.org> evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] EVMS announcement
Date: Wed, 6 Nov 2002 07:47:15 -0600
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
References: <02110516191004.07074@boiler> <02110518360200.00235@cygnus> <20021106022549.C849B55A9@dominion.dyndns.org>
In-Reply-To: <20021106022549.C849B55A9@dominion.dyndns.org>
MIME-Version: 1.0
Message-Id: <02110607471500.00233@cygnus>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 November 2002 19:45, Mike Diehl wrote:
>
> I don't know if you remember me, but you bailed me out from some trouble I
> had with LVM.... TWICE!

I do in fact remember you. :)  If I scrounge around on my computer at work, I 
could probably still find all the information you sent me about the problems 
you were having.

> So, let me try to understand.  The EVMS team is going to rip out the guts
> of their user-land utils in order to comply with the existing (mainstream)
> API, and abandon their own API.  This should reduce the amount of code
> actually in the kernel.  (ignoring the user-land v. kernel-level discovery
> debate)

To say we are going to rip out the guts of the user-land tools is probably a 
bit extreme. The user tools already do their own version of volume discovery, 
separate from the kernel. So since that logic already exists, we simply need 
to add some processing after that discovery to communicate with the kernel 
drivers to activate the volumes. And yes, this dramatically reducing the 
amount of kernel code needed. In our current kernel driver, I'd say easily 50 
to 75% of the code was just for the in-kernel volume discovery.

> Na, I can't ignore the debate.  I can't wait to see how user-land descovery
> will be implemented.  There is something intrinsically "nice" about having
> an OS automatically discover every aspect of a machine I'm installing on. 
> I guess it's going to fall to the Linux distributors to package this system
> well.  If they don't, first-time Mandrake or RH installers will be doomed
> to that (shudder) other operating system.

Yes, in order for something like volume management to be easy and seemless to
user, it should be presented to them at the time they install their system. 
Having to go back and setup up volumes after the OS is installed is 
definitely cumbersome. We are hoping this change will make it easier for EVMS 
to work on a wider variety of distributions. But we are already on our way. 
We've done a lot of work with UL, Debian, and Gentoo, and this will hopefully 
make things easier for those folks in the long run.

> I'll just have to wait.  BTW, Kevin, if you are ever in Albuquerque, NM. 
> let me know; I still owe you a beer. <grin>

Thanks. I'll keep that in mind. :)

-Kevin
