Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274866AbRIUXNi>; Fri, 21 Sep 2001 19:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274868AbRIUXN3>; Fri, 21 Sep 2001 19:13:29 -0400
Received: from [24.254.60.25] ([24.254.60.25]:41899 "EHLO
	femail35.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S274866AbRIUXNU>; Fri, 21 Sep 2001 19:13:20 -0400
Date: Fri, 21 Sep 2001 19:12:58 -0400 (EDT)
From: Garett Spencley <gspen@home.com>
X-X-Sender: <gspen@localhost.localdomain>
To: Tony Hoyle <tmh@nothing-on.tv>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Reiserfs does not work from fstab in 2.4.9-ac12
In-Reply-To: <9og6rk$vd$1@sisko.my.home>
Message-ID: <Pine.LNX.4.33L2.0109211906280.997-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just experienced the same problem upgrading from 2.4.9-ac7 to
2.4.9-ac13. I was just about to start an investigation when I saw your
e-mail.

What happened in my case is that all my filesystems are reiserfs. The
root filesystem was mounted succesfully for some reason but when it tried
to mount the others it gave "wrong fs type or bad superblock"
for every reiserfs partition (which includes /usr, /var, /tmp etc. So I
had to reboot back into -ac7).

I'll post a "bug report" after I investigate and find out what the
problem is. I just wanted to post this e-mail to say that you're not the
only one who's had a problem.

-- 
Garett Spencley

I encourage you to encrypt e-mail sent to me using PGP
Public key at http://www.geocities.com/gspencley/public_key.txt
Key fingerprint: 8062 1A46 9719 C929 578C BB4E 7799 EC1A AB12 D3B9

On Fri, 21 Sep 2001, Tony Hoyle wrote:

> I just got caught by this on a box which had a reiserfs /usr partition...
>
> # mount /disk2
> reiserfs: kgetopt: there is not option
> <lots of mount failure stuff>
>
> The fstab that generated this (which has worked for every other version,
> so I believe it to be correct):
> /dev/hdb1      /disk2          reiserfs        defaults        0       0
>
> However
> # mount -t reiserfs /dev/hdb1 /disk2
>
> ..works correctly.
>
> Tony
>
>


