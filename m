Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750986AbWFLUhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbWFLUhi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 16:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbWFLUhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 16:37:38 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:35490 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750986AbWFLUhi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 16:37:38 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] revert "swsusp: fix breakage with swap on lvm"
Date: Mon, 12 Jun 2006 22:38:04 +0200
User-Agent: KMail/1.9.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
References: <200603231702.k2NH2MUS006739@hera.kernel.org> <200606121221.13867.rjw@sisk.pl> <20060612122510.GA26600@redhat.com>
In-Reply-To: <20060612122510.GA26600@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606122238.04572.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 June 2006 14:25, Dave Jones wrote:
> On Mon, Jun 12, 2006 at 12:21:13PM +0200, Rafael J. Wysocki wrote:
> 
>  > > So, now I'm getting bug reports from users about .17rc breaking
>  > > their resume again. (https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=194784)
>  > > 
>  > > If this was a temporary thing, what should we be doing to keep
>  > > old installations working ?
>  > 
>  > This was temporary, because the handling of it has been moved to
>  > kernel/power/swap.c and mm/swapfile.c now, but the code has not changed much
>  > (surely it doesn't return -ENODEV if swsusp_resume_device is not set).
>  > Moreover, the new code has been in -rc since 2.6.17-rc1.
>  > 
>  > The report you are referring to is for the kernel called 2.6.16-1.2255_FC6. 
>  > Is this just 2.6.17-rc* renamed or is it related to -rc in another way?
> 
> Yes, it's .17rc6.
> (They only become a 2.6.17-x after .17 is final)

Clear.

Well, I need some more information.

I don't think the breakage has been caused by any of my patches this time, so
I'll have to figure out what else might have caused it.  [The problem is last
significant changes in swsusp that might be related to this were commited
a couple of months ago. ;-) ]

Greetings,
Rafael
