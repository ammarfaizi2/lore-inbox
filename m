Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290945AbSBLKPV>; Tue, 12 Feb 2002 05:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290944AbSBLKPL>; Tue, 12 Feb 2002 05:15:11 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:17161 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S290930AbSBLKOz>; Tue, 12 Feb 2002 05:14:55 -0500
Date: Tue, 12 Feb 2002 11:14:46 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: <roman@serv>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: "David S. Miller" <davem@redhat.com>, <davidm@hpl.hp.com>,
        <anton@samba.org>, <linux-kernel@vger.kernel.org>
Subject: Re: thread_info implementation
In-Reply-To: <3C68E0C3.543A1AD6@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0202121105300.11589-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 12 Feb 2002, Jeff Garzik wrote:

> ...or number 3, do a conversion to 2.5.4 thread_info then embed the task
> structure inside struct thread_info, like what was just done with VFS
> inodes.

That's possible.

>  (embedding the general struct in the arch-specific struct would
> make sense to me, whereas I can definitely see how embedding the
> arch-specific struct in the general struct would be annoying)

It's not really the same, the private part of the inode is really private
to the specific fs. thread_info is arch specific, but it fields have to be
accessed by generic code. At compile time there is also always only one
thread_info contrary to vfs inodes.
Anyway, it's not really important which structure includes which, it just
has to be decided for all archs uniformly to get include dependencies
right.

bye, Roman

