Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131659AbRCSXL3>; Mon, 19 Mar 2001 18:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131654AbRCSXLU>; Mon, 19 Mar 2001 18:11:20 -0500
Received: from james.kalifornia.com ([208.179.59.2]:31044 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S131653AbRCSXLI>; Mon, 19 Mar 2001 18:11:08 -0500
Message-ID: <3AB62254.5CB508AB@kalifornia.com>
Date: Mon, 19 Mar 2001 07:14:28 -0800
From: Ben Ford <ben@kalifornia.com>
X-Mailer: Mozilla 4.73C-CCK-MCD Caldera Systems OpenLinux [en] (X11; U; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeremy Jackson <jerj@coplanar.net>
CC: root@chaos.analogic.com, Brian Gerst <bgerst@didntduck.org>,
        Otto Wyss <otto.wyss@bluewin.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Linux should better cope with power failure
In-Reply-To: <Pine.LNX.3.95.1010319162020.12070A-100000@chaos.analogic.com> <3AB6850A.4D7FDA26@coplanar.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Actually, I think /etc/mtab is not needed at all.   Originally, UNIX
> used to put as much onto the disk (and not in "core") as possible.
> so much state information related only to one boot-cycle was
> taken out of kernel and stored on disk.  /var/run/utmp, /etc/mtab,
> , rmtab,  and many others.  all are invalidated by a reboot, and are yet
> stored
> in non-volatile storage.  kernel memory is not swappable, so they manually
> separated out the minimum needed in core.
>
> Linux currently has a lot of this info in core, and maintains the disk files
> for backwards compatibility.  in the case of /etc/mtab, I believe
> /proc/mounts
> has the same info.  It appears to be in the same format as /etc/mtab,
> so most of the groundwork has already been done.
> i've considered trying just changing /etc/mtab to /proc/mounts in some
> utilities, to remove the need for read-write root.  This (and other cases)
> would guarantee consistency (look at /etc/mtab after restart in single
> user more - ugh)

It has been suggested to ln -sf /proc/mounts /etc/mtab.  Linus has said this, I
believe.

-b


