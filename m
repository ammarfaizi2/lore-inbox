Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268374AbTAMW1m>; Mon, 13 Jan 2003 17:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268375AbTAMW1m>; Mon, 13 Jan 2003 17:27:42 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:53509 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S268374AbTAMW1j>; Mon, 13 Jan 2003 17:27:39 -0500
Message-ID: <3E23390F.29FF27D3@linux-m68k.org>
Date: Mon, 13 Jan 2003 23:09:19 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: why the new config process is a *big* step backwards
References: <Pine.LNX.4.44.0301130743100.25468-100000@dell>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

"Robert P. J. Day" wrote:

>   first, the hierarchical structure of the options in the left
> window (i'm going to make up names and call these the "menu window",
> "option window" and "help window") is non-intuitive, in that the
> top-level selection will bring up a set of selectable options,
> while submenus will *also* bring up options.

The option window will likely get a back button.
How the option window works might not be obvious, but I don't think it's
that difficult to find out how it works, but I'm always open to
suggestion to improve this.

>   example:  Power management options.  if i select that menu
> option explicitly, i get options including APM in the option
> window.  but if i expand that option, i can select the submenu
> "ACPI Support", for further options.  this is confusing --
> it's analogous to a directory having files both directly inside
> it *and* within a sub-structure.

The problem here is that the Kconfig files weren't directly written for
the new config tool, so it has to make the best out of it. There is of
course enough room for improvement.

>   there's no reason to not have checkboxes *right* *in*
> the menu window, so i can see *immediately* whether i have
> entire submenu options selected.

A patch to make this possible is available, but it needs a bit more
work.

>   at least in the old "make xconfig", i could bring up two
> children dialogs at a time.  perhaps i want to examine/configure
> both "Block devices" and "Filesystems" at the same time, since
> there are some related features (loopback device support under
> Block devices lets me mount filesystem images).  under the
> new scheme, this is impossible (unless there's a trick or
> feature i haven't found).

Have you found the full tree mode?
I'm thinking about the option to open a submbenu in its own window, but
it will not be the default. I really hate it when a program thinks it
has to open a new window for everything.

>   and that option window is just confusing.  given that we
> already have +/- expand/collapse icons, and checkboxes for
> selection, it just makes things messier to have these submenu
> boxes with the internal triangle.  and once it takes you to
> that submenu, is it really painfully obvious how you back up
> one level?  (the arrow icon in the tool bar?)

Offering too many options at once is not good either, as then you have
the choice that you must expand lots of submenus until you find, what
you need or you have a huge list of options. The current window is a
compromise, which doesn't show too much and already has everything
expanded. If possible I would omit the +/- icons, but it's not possible
without reimplementing the whole widget.

bye, Roman


