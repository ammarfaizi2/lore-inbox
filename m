Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293326AbSB1Ly5>; Thu, 28 Feb 2002 06:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293327AbSB1Lwe>; Thu, 28 Feb 2002 06:52:34 -0500
Received: from miranda.axis.se ([193.13.178.2]:17886 "EHLO miranda.axis.se")
	by vger.kernel.org with ESMTP id <S293326AbSB1LwT>;
	Thu, 28 Feb 2002 06:52:19 -0500
Date: Thu, 28 Feb 2002 12:52:04 +0100 (CET)
From: Bjorn Wesen <bjorn.wesen@axis.com>
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>,
        Sebastian Sjoberg <sebastian.sjoberg@axis.com>
Subject: Re: Sync over loop devices takes ages? [2.4.17]
In-Reply-To: <20020228095955.GH774@elf.ucw.cz>
Message-ID: <Pine.LNX.3.96.1020228124904.14657F-100000@fafner.axis.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2002, Pavel Machek wrote:
> I have a script (attached). At one point it tries to do sync... That
> sync take a long time, with disk mostly unused. vmstat says:

> Any comments, fixes, etc?

We noticed something on a 2.4.17 machine here yesterday.. might not be
related.. but both sync and umount of a loop-mounted ext2 filesystem
caused the umount/sync process to hang in the D-state. The loop0 kernel
thread hung in the same state. And this was 100% reproducible, on THAT
box at least with that ext2 filesystem-image.

-BW

