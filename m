Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267117AbTB0XuY>; Thu, 27 Feb 2003 18:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267277AbTB0XuX>; Thu, 27 Feb 2003 18:50:23 -0500
Received: from uucp.cistron.nl ([62.216.30.38]:61959 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S267117AbTB0XuX>;
	Thu, 27 Feb 2003 18:50:23 -0500
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: Patch: 2.5.62 devfs shrink
Date: Fri, 28 Feb 2003 00:00:42 +0000 (UTC)
Organization: Cistron Group
Message-ID: <b3m8ra$i9d$3@news.cistron.nl>
References: <200302272313.PAA11724@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1046390442 18733 62.216.29.200 (28 Feb 2003 00:00:42 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200302272313.PAA11724@baldur.yggdrasil.com>,
Adam J. Richter <adam@yggdrasil.com> wrote:
>   devfs, a simpler approach might be to convert your non-devfs
>   system to use devfs-style names, at least for the devices that
>   are needed for booting (/dev/vc/0, /dev/vc/1... for virtual
>   consoles, /dev/discs/disc0/disc for the first whole hard disk,
>   /dev/discs/discs0/part1 for the first partition of the first
>   disk, /dev/floppy/0).

If you're making it not 100% compatible anyway, now is the time
to do away with that horrible 'disc' spelling ;). 'disk' is a
harddisk or floppy disk, 'disc' is for compact disc (try Google
on both spellings and you'll see that the world agrees ..).
Just do s/disc/disk/g in devfs_register().

Mike.
-- 
Anyone who is capable of getting themselves made President should
on no account be allowed to do the job -- Douglas Adams.

