Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314525AbSEPSiY>; Thu, 16 May 2002 14:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314546AbSEPSiX>; Thu, 16 May 2002 14:38:23 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:11532 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S314525AbSEPSiW>; Thu, 16 May 2002 14:38:22 -0400
Date: Thu, 16 May 2002 15:37:49 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Juan Quintela <quintela@mandrakesoft.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19pre8aa3
In-Reply-To: <20020516160754.GR1025@dualathlon.random>
Message-ID: <Pine.LNX.4.44L.0205161536160.32261-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 May 2002, Andrea Arcangeli wrote:
> On Thu, May 16, 2002 at 11:27:37AM +0200, Juan Quintela wrote:
> > I am missing something, or how do you pass the notail option to your
> > reiserfs rootfs when the initrd is ext2.
>
> fair enough (the new initrd API allows that, but it's very ugly that it
> is not dynamic from a kernel param like rootfstype would be, but it
> instead has to be written on disk within the initrd), however as said
> that's all due the brokeness of the rootfs params, they should apply
> only to the fianl real root dev, never to the initrd.

There's another issue.  The real root device might not be known
at the time the initrd is first loaded.

This is the case in some installers, which seem to use pivot_root
after the installer is done so the user doesn't need to reboot
after the install is done...

Of course, the real root device won't be known until after the user
has done the partitioning of the hard disk(s).

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

