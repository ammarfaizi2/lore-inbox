Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbWH3Wcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWH3Wcu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 18:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWH3Wcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 18:32:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64394 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932209AbWH3Wct (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 18:32:49 -0400
Date: Wed, 30 Aug 2006 15:32:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Greg KH <greg@kroah.com>,
       Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH -mm] PM: add /sys/power documentation to
 Documentation/ABI
Message-Id: <20060830153242.c5081692.akpm@osdl.org>
In-Reply-To: <20060830150358.55233204.rdunlap@xenotime.net>
References: <200608302338.06882.rjw@sisk.pl>
	<20060830144350.3b9bb273.akpm@osdl.org>
	<20060830150358.55233204.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2006 15:03:58 -0700
"Randy.Dunlap" <rdunlap@xenotime.net> wrote:

> On Wed, 30 Aug 2006 14:43:50 -0700 Andrew Morton wrote:
> 
> > On Wed, 30 Aug 2006 23:38:06 +0200
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > 
> > > Documentation/ABI/testing
> > 
> > psst, Greg, they're still sending too much stuff: need more paperwork!
> > 
> > Some words about this in Documentation/SubmitChecklist would be nice.
> 
> and people actually using it would be nice(r).

c'mon, it must be taped to 1,000 monitors and bathroom doors by now?

> Is this close to what you are looking for?

I guess so, thanks.  Pointing at the README was sneaky.

> 
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Mention Documenation/ABI/ requirements in Documentation/SubmitChecklist.
> 
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> ---
>  Documentation/SubmitChecklist |    3 +++
>  1 files changed, 3 insertions(+)
> 
> --- linux-2618-rc5all.orig/Documentation/SubmitChecklist
> +++ linux-2618-rc5all/Documentation/SubmitChecklist
> @@ -61,3 +61,6 @@ kernel patches.
>      Documentation/kernel-parameters.txt.
>  
>  18: All new module parameters are documented with MODULE_PARM_DESC()
> +
> +19: All new userspace interfaces are documented in Documentation/ABI/.
> +    See Documentation/ABI/README for more information.

This ABI/ thing rather snuck under my radar (I saw it go past, but a lot of
things go past).

It'll be good if it works, but it is going to take quite a lot of thought,
effort and maintainer vigilance to be successful and to avoid becoming
rotware.

I wonder how hard it would be to write a script which parses a diff, works
out if it touches ABI things, complain if it doesn't alter
Documentation/ABI/*?  Not very - it's just a matter of defining a suitable
regexp.

What _should_ be documented in there, anyway?

- syscalls, obviously.

- /proc?  If so, everything, or are there exceptions?

- /sys?  If so, everything, or are there exceptions?

- ioctl numbers and payloads?

- netlink messages?

- ethtool thingies?  netdev interface names?  /proc/iomem identifiers? 
  module names?  kernel-thread comm[] contents?  The ABI is pretty fat.

scary.
