Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130105AbQLPWXh>; Sat, 16 Dec 2000 17:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130128AbQLPWXQ>; Sat, 16 Dec 2000 17:23:16 -0500
Received: from [194.213.32.137] ([194.213.32.137]:4 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S130107AbQLPWXN>;
	Sat, 16 Dec 2000 17:23:13 -0500
Message-ID: <20001215235446.H9506@bug.ucw.cz>
Date: Fri, 15 Dec 2000 23:54:46 +0100
From: Pavel Machek <pavel@suse.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: recursive exports && linux nfs
In-Reply-To: <20001212103652.A13501@cerebro.laendle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20001212103652.A13501@cerebro.laendle>; from Marc Lehmann on Tue, Dec 12, 2000 at 10:36:53AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I am trying to export the whole filesystem hierarchy on one of my servers
> (this includes /fs, which is an automounted directory using autofs).
> 
> Now I have two problems:
> 
> 1) exporting: exportfs does not really exports filesystems that are
>    not present when exportfs is being called (some of my filesystems
>    are only available temporarily). Also, exportfs of course forces the mount
>    of all filesystems that are mountable, which can take considerable time.
> 
> 2) using: I can do cd /nfs/fs, but the directoy is always empty, and when I
>    try to step into a subdirectory I always get "No such file or directory".
> 
> I am using linux-2.2.18, nfsv3 + nfs-utils-0.2.1.
> 
> Thanks a lot for any insights, even if this means "this is not supported"
> ;)

This can't be supported, afaict, because nfs handles have limited
size.

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
