Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264091AbRFETq2>; Tue, 5 Jun 2001 15:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264090AbRFETqS>; Tue, 5 Jun 2001 15:46:18 -0400
Received: from pille1.addcom.de ([62.96.128.35]:40976 "HELO pille1.addcom.de")
	by vger.kernel.org with SMTP id <S264089AbRFETqM>;
	Tue, 5 Jun 2001 15:46:12 -0400
Date: Tue, 5 Jun 2001 21:45:48 +0200 (CEST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: "W. Michael Petullo" <mike@flyn.org>
cc: Ivan <pivo@pobox.sk>, <linux-kernel@vger.kernel.org>
Subject: Re: PID of init != 1 when initrd with pivot_root
In-Reply-To: <20010605175618.A2884@dragon.flyn.org>
Message-ID: <Pine.LNX.4.33.0106051939540.9711-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jun 2001, W. Michael Petullo wrote:

> > But the problem still remains. How do I make my /sbin/init run with PID 1
> > using initial ramdisk under the new root change mechanism? I don't want to
> > use the old change_root mechanism...
>
> I had the same problem when doing some development for mkCDrec.
> This project uses busybox, whose init does not run if its PID != 1.
> I asked the busybox folks same question you did and never got a response.

Maybe I'm wrong here, but I had the same problem at some point and my
solution was to rename /linuxrc (to /linux, and booting with init=/linux).
I believe the code which special cases /linuxrc might be in the way here.

Maybe you want to try this, if it helps I think Documentation/initrd.txt
needs to be updated.

--Kai



