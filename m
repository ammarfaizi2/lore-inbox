Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264760AbSLBDSU>; Sun, 1 Dec 2002 22:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264766AbSLBDSU>; Sun, 1 Dec 2002 22:18:20 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:38415
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S264760AbSLBDSF>; Sun, 1 Dec 2002 22:18:05 -0500
Subject: Re: a bug in autofs
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: "Andrey R. Urazov" <coola@ngs.ru>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021201071612.GA936@ktulu>
References: <20021201071612.GA936@ktulu>
Content-Type: text/plain
Organization: 
Message-Id: <1038799532.15370.301.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 01 Dec 2002 19:25:32 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-11-30 at 23:16, Andrey R. Urazov wrote:
> 1) when I run XMMS and its playlist contains entries laying somewhere
>    under /misc/cdrom but there is no cd in the drive or the cd in the
>    drive is not the one whose entries are stored in the playlist, it
>    takes about half a minute for the system to hang. Before it hangs
>    absolutely I get numerous messages "invalid seek on /dev/hdc" on my
>    virtual consoles

What happens if you try to manually mount the cdrom when there's nothing
in the drive?

> 2) under /misc/summer there resides an ntfs volume with thousands of
>    files. And when I run 
> 
>         find /misc/summer
> 
>    the system becames unusable after some amount of files is scanned.
>    Usually it just hangs. But one time "find" terminated with the
>    segmentation fault and then after 5 seconds or so the system hung.

Can you reproduce this with some other filesystem type (something which
is less flaky than NTFS)?

How many files are on the NTFS filesystem?

> The problem does not existed if the volumes are mounted through "mount".
> Only automounting causes problems.

Does this comment also apply to the cdrom case?

What mount options are you using to mount these filesystems?  Are they
the same when you do it manually and using autofs?

What does the "dentry_cache" line say in /proc/slabinfo while you're
running the find on the NTFS filesystem?

Thanks,
	J

