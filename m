Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130596AbRBSQvf>; Mon, 19 Feb 2001 11:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129907AbRBSQvZ>; Mon, 19 Feb 2001 11:51:25 -0500
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:27635 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S130597AbRBSQvP>; Mon, 19 Feb 2001 11:51:15 -0500
Date: Mon, 19 Feb 2001 17:51:05 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: David Balazic <david.balazic@uni-mb.si>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Flusing caches on shutdown
Message-ID: <20010219175105.J724@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <3A911585.E0A8006E@uni-mb.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3A911585.E0A8006E@uni-mb.si>; from david.balazic@uni-mb.si on Mon, Feb 19, 2001 at 01:45:57PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2001 at 01:45:57PM +0100, David Balazic wrote:
> It is a good idea IMO to flush the write cache of storage devices
> at shutdown and other critical moments.

Not needed. All device drivers should disable write caches of
their devices, that need another signal than switching it off by
the power button to flush themselves.

> Loosing data at powerdown due to write caches have been reported,
> so this is no a theoretical problems. Also the journaled filesystems
> are safe only in theory if the journal is not stored on non-volatile
> memory, which is not guarantied in the current kernel.

Fine. If users/admins have write caching enabled, they either
know what they do, or should disable it (which is the default for
all mass storage drivers AFAIK).

Hardware Level caching is only good for OSes which have broken
drivers and broken caching (like plain old DOS).

Linux does a good job in caching and cache control at software
level.

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<       come and join the fun       >>>>>>>>>>>>
