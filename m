Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315631AbSFOWkq>; Sat, 15 Jun 2002 18:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315690AbSFOWkp>; Sat, 15 Jun 2002 18:40:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3088 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315631AbSFOWko>;
	Sat, 15 Jun 2002 18:40:44 -0400
Message-ID: <3D0BC34E.BAE89EB9@zip.com.au>
Date: Sat, 15 Jun 2002 15:44:30 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Jacobowitz <drow@false.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Inexplicable disk activity trying to load modules on devfs
In-Reply-To: <20020615172244.C19123@crack.them.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jacobowitz wrote:
> 
> I just booted into 2.4.19-pre10-ac2 for the first time, and noticed
> something very odd: my disk activity light was flashing at about
> half-second intervals, very regularly, and I could hear the disk
> moving.  I was only able to track it down to which disk controller, via
> /proc/interrupts (are there any tools for monitoring VFS activity?
> They'd be really useful).  Eventually I hunted down the program causing
> it: xmms.
> 
> The reason turned out to be that I hadn't remembered to build my sound
> driver for this kernel version.  Every half-second xmms tried to open
> /dev/mixer (and failed, ENOENT).  Every time it did that there was
> actual disk activity.  Easily reproducible without xmms.  Reproducible
> on any non-existant device in devfs, but not for nonexisting files on
> other filesystems.  Is something bypassing the normal disk cache
> mechanisms here?  That doesn't seem right at all.
> 

syslog activity from a printk, perhaps?

-
