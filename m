Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271551AbRHZU3y>; Sun, 26 Aug 2001 16:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271552AbRHZU3e>; Sun, 26 Aug 2001 16:29:34 -0400
Received: from postfix2-1.free.fr ([213.228.0.9]:49161 "HELO
	postfix2-1.free.fr") by vger.kernel.org with SMTP
	id <S271551AbRHZU31> convert rfc822-to-8bit; Sun, 26 Aug 2001 16:29:27 -0400
Date: Sun, 26 Aug 2001 22:26:49 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: <pcg@goof.com>, Rik van Riel <riel@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
In-Reply-To: <20010826172310Z16216-32383+1477@humbolt.nl.linux.org>
Message-ID: <20010826220717.E16170-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 26 Aug 2001, Daniel Phillips wrote:

[...]

> It should not be being ignored.  This needs to be looked into.  In any event,
> the max-readahead proc setting is clearly good and needs to be in Linus's
> tree, otherwise changing the default MAX_READAHEAD requires a recompile.
> Worse, there is no way at all to specify the kernel's max-readahead for scsi
> disks - regardless of the fact that scsi disks do their own readahead, the
> kernel will do its own as well, with no way for the user to turn it off.

For SCSI disks prefetch tuning you may look into the CACHING page.

For example, you can tell the drive to stop prefetching as soon a command
is ready by setting MINIMUM PRE-FETCH to zero.

Unfortunately, not all SCSI disks allow to tune all the configuration
parameters of the caching page.

[...]

  Gérard.

