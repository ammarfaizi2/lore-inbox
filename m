Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264984AbUIVNPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264984AbUIVNPa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 09:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265106AbUIVNPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 09:15:30 -0400
Received: from main.gmane.org ([80.91.229.2]:2198 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264984AbUIVNPN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 09:15:13 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Mario R. Carro" <mcarro@threads-srl.com>
Subject: Re: FUSE fusexmp proxy example solves umount problem!
Date: Wed, 22 Sep 2004 10:15:05 -0300
Message-ID: <cirtsq$4j5$1@sea.gmane.org>
References: <20040922004941.GC14303@lkcl.net>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 200.80.238.173
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2800.1437
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had exactly the same idea. I've setup an little project on SourceForge
(http://sf.net/projects/rmvfs). It's just a crude proof of concept by now.

I was thinking in cdroms and diskettes, but I suppose that it applies also
to usb sticks. My original motivation was the cdroms and zip disks being
kept locked in the drives.

I wanted to be able to:
- use the media without needing an explicit mount op (as autofs does).
- be able to extract the media at any time, without an explicit umount and
without being blokced by any lagging process.
- Avoid the risk of corruption.

So:
- the rmvfs mountpoint is always mounted, no explicit mount required.
- rmvfs maintains the target drive always unmounted (unless there's an
operation in progress) so it is safe to extract the media at any time.
- And finally, as you say, by virtue of the proxing, you are always free to
extract the media without problems.

It's performance is very bad but for accessing already slow media (diskettes
and zips) it's fine. The added confort of use it's what it counts, I think,
anyway.

Regards,

MRC

-- 

"Luke Kenneth Casson Leighton" <lkcl@lkcl.net> escribió en el mensaje
news:20040922004941.GC14303@lkcl.net...
> what do people think about a filesystem proxy kernel module?
> has anyone heard of such a beast already?
> (which can also do xattrs)
>
> fusexmp.c (in file system in userspace package) does stateless
> filesystem proxy redirection.
>
> this is a PERFECT solution to the problem of users removing media
> from drives without warning.  when i say perfect i mean it doesn't
> cause kernel hang-ups, it doesn't involve modifications to userspace
> programs such as KDE or Gnome, it doesn't involve any extra work
> to HAL, nor UDEV.
>
> it just... _works_.
>
> but, doing file system proxying in userspace introduces an additional
> and unnecessary level of inefficiency.
>
> i was wondering therefore if anyone had attempted to do filesystem
> proxying before.
>
> ta,
>
> l.
>
> -- 
> --
> Truth, honesty and respect are rare commodities that all spring from
> the same well: Love.  If you love yourself and everyone and everything
> around you, funnily and coincidentally enough, life gets a lot better.
> --
> <a href="http://lkcl.net">      lkcl.net      </a> <br />
> <a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />
>




