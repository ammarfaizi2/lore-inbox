Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265711AbSLBIbl>; Mon, 2 Dec 2002 03:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265713AbSLBIbl>; Mon, 2 Dec 2002 03:31:41 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:11280
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S265711AbSLBIbl>; Mon, 2 Dec 2002 03:31:41 -0500
Subject: Re: a bug in autofs
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: "Andrey R. Urazov" <coola@ngs.ru>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021202075725.GC1459@ktulu>
References: <20021201071612.GA936@ktulu>
	 <1038799532.15370.301.camel@ixodes.goop.org>  <20021202075725.GC1459@ktulu>
Content-Type: text/plain
Organization: 
Message-Id: <1038818346.3253.17.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 02 Dec 2002 00:39:06 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-12-01 at 23:57, Andrey R. Urazov wrote:
> On Sun, Dec 01, 2002 at 07:25:32PM -0800, Jeremy Fitzhardinge wrote:
> > What happens if you try to manually mount the cdrom when there's nothing
> > in the drive?
> [root@ktulu coola]# en mount -o ro -t iso9660 /dev/cdrom /mnt
> mount: No medium found
> 
> with this attempt a new line reading `cdrom: open failed' is appended to
> the dmesg output

Don't really know about this.  Autofs just uses mount to mount the
filesystem, so whatever happens when you manually mount should also
happen when you automount.  What's "en"?  Is this the same mount command
line as automount execs?  What's in your auto.master?  Which module are
you using?

> Sorry for misinforming you. When this was written I tried manual
> mounting only once and all was okay during this trial. But when
> I repeated the test, the system crashed as in the case of automounting.
> And I didn't manage to perform a succesful find over ntfs volume once
> more. So the problem here is probably in the ntfs driver, not autofs.

That's what I suspected was happening, but I wanted to be sure.

	J

