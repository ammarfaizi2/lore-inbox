Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271594AbRHZVN5>; Sun, 26 Aug 2001 17:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271592AbRHZVNi>; Sun, 26 Aug 2001 17:13:38 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:15373 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271581AbRHZVNe>; Sun, 26 Aug 2001 17:13:34 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Daniel Phillips <phillips@bonn-fries.net>
To: =?iso-8859-1?q?G=E9rard=20Roudier=20?= <groudier@free.fr>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Date: Sun, 26 Aug 2001 23:20:24 +0200
X-Mailer: KMail [version 1.3.1]
Cc: <pcg@goof.com>, Rik van Riel <riel@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <20010826220717.E16170-100000@gerard>
In-Reply-To: <20010826220717.E16170-100000@gerard>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20010826211349Z16294-32384+570@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 26, 2001 10:26 pm, Gérard Roudier wrote:
> On Sun, 26 Aug 2001, Daniel Phillips wrote:
> 
> [...]
> 
> > It should not be being ignored.  This needs to be looked into.  In any event,
> > the max-readahead proc setting is clearly good and needs to be in Linus's
> > tree, otherwise changing the default MAX_READAHEAD requires a recompile.
> > Worse, there is no way at all to specify the kernel's max-readahead for scsi
> > disks - regardless of the fact that scsi disks do their own readahead, the
> > kernel will do its own as well, with no way for the user to turn it off.
> 
> For SCSI disks prefetch tuning you may look into the CACHING page.
> 
> For example, you can tell the drive to stop prefetching as soon a command
> is ready by setting MINIMUM PRE-FETCH to zero.
> 
> Unfortunately, not all SCSI disks allow to tune all the configuration
> parameters of the caching page.

In this case he's using ide.

--
Daniel
