Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317217AbSGHXVX>; Mon, 8 Jul 2002 19:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317251AbSGHXVW>; Mon, 8 Jul 2002 19:21:22 -0400
Received: from mtiwmhc21.worldnet.att.net ([204.127.131.46]:44439 "EHLO
	mtiwmhc21.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S317217AbSGHXVW>; Mon, 8 Jul 2002 19:21:22 -0400
Date: Mon, 8 Jul 2002 19:27:10 -0400
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Terrible VM in 2.4.11+?
Message-ID: <20020708232710.GA6798@lnuxlab.ath.cx>
References: <20020709001137.A1745@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020709001137.A1745@mail.muni.cz>
User-Agent: Mutt/1.3.28i
From: khromy@lnuxlab.ath.cx (khromy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2002 at 12:11:37AM +0200, Lukas Hejtmanek wrote:
> 
> Hello,
> 
> as of the last stable version 2.4.18 VM management does not work for me
> properly. I have Athlon system with 512MB ram, 2.4.18 kernel without any
> additional patches.
> 
> I run following sequence of commands:
> 
> dd if=/dev/zero of=/tmp bs=1M count=512 &
> find / -print &
>  { wait a few seconds }
> sync
> 
> at this point find stops completely or at least almost stops.
> 
> The same if I copy from /dev/hdf to /dev/hda. XOSVIEW shows only reading or only

Wow, this is the same problem I was having!  Checkout the thread 'sync
slowness. ext3 on VIA vt82c686b'.  Some said it was my harddrive, but
this morning I noticed the problem is gone!

After I copy the file, sync returns right away.  I'm running
2.4.19-rc1aa1 now.

-- 
L1:	khromy		;khromy(at)lnuxlab.ath.cx
