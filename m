Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932496AbVHZK3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbVHZK3q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 06:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbVHZK3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 06:29:46 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:324 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751074AbVHZK3p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 06:29:45 -0400
Date: Fri, 26 Aug 2005 12:29:43 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: robotti@godmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Initramfs and TMPFS!
Message-ID: <20050826102943.GA28640@harddisk-recovery.com>
References: <200508251815.j7PIFDGe026463@ms-smtp-02.rdc-nyc.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508251815.j7PIFDGe026463@ms-smtp-02.rdc-nyc.rr.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2005 at 02:15:13PM -0400, robotti@godmail.com wrote:
> 
>    >Could you please please pretty please get an RFC compliant mailer that
>    >generates  "In-Reply-To" and preferable even "References" headers?
>    >Right
>    >now every mail you write starts a new thread instead of referencing to
>    >the previous one. See http://lkml.org/lkml/2005/8/25/180/ to see what
>    >I mean.
> 
> I'm not subscribed to the list and I use lynx and a small mda
> called msmtp, so I know it's awkward (perhaps mostly for me).

No, it's mostly awkward for the people reading linux-kernel.
Linux-kernel is a very high volume mailing list, and proper use of
email threading is *vital* to read it: you immediately get all
references to previous messages, and it makes it easy to skip threads
you're not interested in (nobody except Alan Cox and his gnomes reads
every message to linux-kernel).

If you're not subscribed, the normal way is to:

- Ask to be Cc'ed (that usually happens anyway).
- Reply to the sender, the list, and everybody else in the Cc list.
- Keep In-Reply-To and References headers so the other subscribers know
  what to read and what not.

> But, that's my setup.

It would never occur to me to use something as inappropriate as a web
browser as a mail client...

> Perhaps if the list had a followup/reply option, I could use that in lynx.

It hasn't for good reasons. Read the LKML FAQ at http://www.tux.org/lkml/ .

> But, the list just seems to be useful for reading purposes.
> 
> Perhaps I could access the list through a newsreader and the
> replys would be threaded/referenced.

Please do so. It will certainly help you to get more/different replies.

>    >Cpio is perhaps as available as tar, but it's not as used as tar.
>    >>So? Firefox is as available as IE, but it's not as used as IE. Does
>    >>that make IE better?
>    
> I have no opinion on which one is better.
>    
> I prefer tar because I have more experience with it, and it works.

The kernel people prefer cpio because they have experience with it, it
doesn't need too much code, and it works.

> It seems to be the most used archiver in the UNIX world.

You've been told that there are *technical* reasons not to use tar in
the kernel. The kernel developers never cared about what was most used
or what "the market wants", but only about what was *technically* useful.

>    >I know generally an initrd is used to load modules and prepare
>    >the installation of a Linux system, so it doesn't require much
>    >in a filesystem.
>    >>An initramfs can be used to do the same, but doesn't have the overhead
>    >>of a block device. IOW: it requires even *less* than an initrd.
>    
> Right, an initramfs can/should replace the old initrd method, but
> it should be comparable and have a filesystem like tmpfs as an option.

Initramfs using ramfs *is* comparable and it *has* a filesystem.

> The old initrd method could use any filesystem for the initrd
> that the kernel could support, but now with initramfs all you
> have is ramfs.

Did you ever take some time to actually *understand* what ramfs is,
*why* it is used for initramfs, and why you can't use any filesystem
you like for an initramfs?

> If you add tmpfs to initramfs you make initramfs comparable enough
> (on the filesystem level) to replace the old initrd method.

Read the code, ramfs *is* comparable to the old initrd method, and
tmpfs is the same as ramfs with the difference that its pages can be
swapped out.

> Initramfs is already ahead of the old initrd method on other levels.

It is, but mostly because it makes the kernel boot procedure so much
easier and removes a lot of special cases in the code.

>    >But, it can also be used to hold and run a complete Linux system,
>    >so a more robust filesystem (tmpfs) is useful.
>    >>What makes you think tmpfs is more robust than ramfs? What do you mean
>    >>with a "robust filesystem"?
> 
> I've used tmpfs and ramfs, so it's based on experience.

You have used both, so why is tmpfs a "robust filesystem" and ramfs
not? Again, what is your definition of a "robust filesystem"?

> I'm sure someone could give you a more technical answer, but if
> you're a coder you would probably already know.
> 
> For one, if you do "dd if=/dev/zero of=foo" on a ramfs the system
> will lock up.

"Doctor, it hurts when I do this!" "Well, then don't do that."
You found a nice case of "Unix, rope, foot".


Erik

PS: I'm not going to hunt through my linux-kernel mailbox for replies
  without proper In-Reply-To and References headers in the hope that I
  stumble over a possible reply from you. Any reply without such
  headers will most probably not been seen and just ignored.

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
