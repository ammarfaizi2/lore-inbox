Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285291AbRLSO1J>; Wed, 19 Dec 2001 09:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285303AbRLSO07>; Wed, 19 Dec 2001 09:26:59 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:51719 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S285291AbRLSO0u>; Wed, 19 Dec 2001 09:26:50 -0500
Date: Wed, 19 Dec 2001 17:26:44 +0300
From: Oleg Drokin <green@namesys.com>
To: Masaru Kawashima <masaruk@gol.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
        reiserfs-list <reiserfs-list@namesys.com>, chris@suse.de
Subject: Re: [reiserfs-list] reiserfs remount problem (Re: Linux 2.4.17-rc2)
Message-ID: <20011219172644.A28692@namesys.com>
In-Reply-To: <Pine.LNX.4.21.0112181824020.4821-100000@freak.distro.conectiva> <20011219230812.049c2c5c.masaruk@gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011219230812.049c2c5c.masaruk@gol.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Dec 19, 2001 at 11:08:12PM +0900, Masaru Kawashima wrote:

> > - Reiserfs fixes				(Oleg Drokin/Chris Mason)

> There is still reiserfs remount problem with 2.4.17-rc2.
Hmmm.
Few things needs to be verified:
Is your reiserfs root partition 3.5 or 3.6 format? (can be checked in /proc/fs/reiserfs/.../version
Try to boot of different media (rescue disk/CD) and run resiserfsck on your root partition,
is there any errors? If yes - then fix them (with reiserfsck --rebuild-tree probably),
and try to boot off your root disk again.
Remember to read FAQ entry on reiserfsck --rebuild-tree on namesys.com web site.

> >>EIP; c0159f54 <_get_block_create_0+748/85c>   <=====
> 00000000 <_EIP>:
> Code;  c0159f54 <_get_block_create_0+748/85c>   <=====
>    0:   0f 0b                     ud2a      <=====
Ok, so it is this code in _get_block_create_0:
        if (!is_direct_le_ih (ih)) {
            BUG ();
        }
Hm.
Is your root partition big?
I want to look at it is that's possible.
At least at the metadata (reiserfsutils contains tools to extract metadata from disk drive,
if you'd extract such metadata and send it to me before you run reiserfsck - that would be great)

Thank you.

Bye,
    Oleg
