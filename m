Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267327AbTALHzf>; Sun, 12 Jan 2003 02:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267328AbTALHzf>; Sun, 12 Jan 2003 02:55:35 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:63501 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267327AbTALHze>;
	Sun, 12 Jan 2003 02:55:34 -0500
Date: Sun, 12 Jan 2003 09:04:06 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: more thoughts on kernel config organization
Message-ID: <20030112080406.GA1006@mars.ravnborg.org>
Mail-Followup-To: "Robert P. J. Day" <rpjday@mindspring.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0301112300570.20815-100000@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301112300570.20815-100000@dell>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2003 at 11:17:46PM -0500, Robert P. J. Day wrote:
>   how about something like
> 
>   ext2
>   ext3
>   reiser
>   XFS
>   JFS
>   quotas
>   MS/DOS related filesystems
>     MD-DOS
>     VFAT
>     NTFS
>   other OS-related filessytems
>     Apple
>     ADFS
>     BeOS
>     BFS
>     QNX
>     System V/XENIX/...
>   Pseudo(?) filessytems
>     /proc
>     /dev/pts
>     /dev

I like the structure proposed above. I for myself has often wondered why
ext2 was not named ext2, and hidden between lots of less used stuff.
If you sort in alphabetic order, then be consistent.

If you are going to reorganise fs/Kconfig I would suggest moving
ext3, reiserfs etc. specific stuff down in their respective directories,
and then source as appropriate.
There is no reason to keep that in a centralised placed, when it can
be distributed.
For simple (Kconfig wise) stuff like CODA or Intermezzo keep them
in fs/KConfig.

	Sam
