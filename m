Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263334AbRFRVhd>; Mon, 18 Jun 2001 17:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263346AbRFRVhX>; Mon, 18 Jun 2001 17:37:23 -0400
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62]:24018 "EHLO
	snipe.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S263334AbRFRVhN>; Mon, 18 Jun 2001 17:37:13 -0400
Message-ID: <3B2E7585.703CEC41@earthlink.net>
Date: Mon, 18 Jun 2001 16:41:25 -0500
From: Kelledin Tane <runesong@earthlink.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Why can't I flush /dev/ram0?
In-Reply-To: <Pine.LNX.3.95.1010618172045.4490A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you have a directory called /initrd, in your root file-system,
> you may find that the old initrd is still mounted:
>
> Script started on Mon Jun 18 17:22:20 2001
> # ls /initrd
> bin  dev  etc  lib  linuxrc  sbin
> # umount /initrd
> # ls /initrd
> # exit
> exit
> Script done on Mon Jun 18 17:22:44 2001
>
> Unmount it first.

I actually had something to that effect in my rc.sysinit file.  It unmounted
/initrd, removed it, and attempted to flush ram0.  I started trying it
manually when that didn't work =(

Funny thing though (not entirely unexpected)--/initrd's not in /etc/mtab.
I can see why.  Also, /proc/sys/kernel/real-root-dev is still 0x0100
(/dev/ram0).  Changing it to 0x0301 (/dev/hda1) doesn't help, but it might be
a clue for those who know this stuff better than I do.

Kelledin

