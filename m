Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271394AbTHDGNx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 02:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271393AbTHDGNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 02:13:53 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:46222 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S271408AbTHDGNu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 02:13:50 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Ben Collins <bcollins@debian.org>
Cc: Steven Micallef <steven.micallef@world.net>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Date: Sun, 3 Aug 2003 23:12:10 -0700 (PDT)
Subject: Re: chroot() breaks syslog() ?
In-Reply-To: <20030804053438.GC31092@phunnypharm.org>
Message-ID: <Pine.LNX.4.44.0308032310150.24695-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

if you need any devices in /dev after the chroot you can create anything
you need in the appropriate directory.

with syslog you need to look at the -a option to syslogd to make things
work the way you want them to.

David Lang

On Mon, 4 Aug 2003, Ben Collins wrote:

> Date: Mon, 4 Aug 2003 01:34:38 -0400
> From: Ben Collins <bcollins@debian.org>
> To: Steven Micallef <steven.micallef@world.net>
> Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
> Subject: Re: chroot() breaks syslog() ?
>
> On Mon, Aug 04, 2003 at 03:49:48PM +1000, Steven Micallef wrote:
> > You're right - my mistake, it doesn't actually work on 2.4.8 either, I think
> > I was looking at the wrong thing when I thought it was actually working.
> >
> > Is it worth considering (optionally) making /dev available to chroot()'ed
> > environments, or would that just defeat the whole purpose of chroot()?
>
> Enable devfs, and you can mount devfs anywhere, even in chroots, and it
> will propogate things like /dev/log.
>
> Generally chroot environments don't want that though.
>
> --
> Debian     - http://www.debian.org/
> Linux 1394 - http://www.linux1394.org/
> Subversion - http://subversion.tigris.org/
> WatchGuard - http://www.watchguard.com/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
