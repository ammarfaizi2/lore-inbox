Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267762AbTAHRgW>; Wed, 8 Jan 2003 12:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267777AbTAHRgW>; Wed, 8 Jan 2003 12:36:22 -0500
Received: from urtica.linuxnews.pl ([217.67.200.130]:29961 "EHLO
	urtica.linuxnews.pl") by vger.kernel.org with ESMTP
	id <S267762AbTAHRgS>; Wed, 8 Jan 2003 12:36:18 -0500
Date: Wed, 8 Jan 2003 18:44:20 +0100 (CET)
From: Pawel Kot <pkot@linuxnews.pl>
To: "Joshua M. Kwan" <joshk@ludicrus.ath.cx>
cc: <folkert@vanheusden.com>, <linux-kernel@vger.kernel.org>
Subject: Re: status of ntfs write-support in 2.4.20
In-Reply-To: <20030108173645.GA27118@kanoe.ludicrus.net>
Message-ID: <Pine.LNX.4.33.0301081838550.16178-100000@urtica.linuxnews.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jan 2003, Joshua M. Kwan wrote:

> On Wed, Jan 08, 2003 at 03:08:54PM +0100, folkert@vanheusden.com wrote:
> > Hi,
> >
> > What is the status of NTFS WRITE(!)-support in 2.4.20?
> > Is there any kernel which can do safely writing to windows nt(! not 2000
> > or xp) partitions?
>
> I believe it is still very unsafe. It *can* be done but you have to mess with
> scandisk everytime you reboot back to windows...it's very very dirty and quite
> hackish. I wouldn't think about risking data on an NTFS partition through the
> limited NTFS driver in Linux 2.4 (even 2.5.)

Well, the ntfs driver from the 2.4.20 vanilla kernel has really dangerous
write support for the ntfs partitions. It is strongly discouraged to use
it.

You can use though the backport driver from the 2.5 kernel series (aka
ntfs-tng). It allows you to overwrite the files using mmap() and write().
So, neither size changes, nor attribute changes. You'll find mode detailes
along with the driver itself at http://linux-ntfs.sf.net/.

> And windows NT/2000/XP partitions are all the same NTFS anyway.

Not really. See http://linux-ntfs.sourceforge.net/info/ntfs.html#1.4

pkot
-- 
mailto:pkot@linuxnews.pl :: mailto:pkot@slackware.pl
http://kt.linuxnews.pl/ :: Kernel Traffic po polsku

