Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261357AbREMABR>; Sat, 12 May 2001 20:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261360AbREMABH>; Sat, 12 May 2001 20:01:07 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:3385 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S261357AbREMAA4>;
	Sat, 12 May 2001 20:00:56 -0400
Message-ID: <20010513020053.B7635@win.tue.nl>
Date: Sun, 13 May 2001 02:00:53 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, viro@math.psu.edu (Alexander Viro)
Cc: szabi@inf.elte.hu (BERECZ Szabolcs), linux-kernel@vger.kernel.org
Subject: Re: mount /dev/hdb2 /usr; swapon /dev/hdb2  keeps flooding
In-Reply-To: <Pine.GSO.4.21.0105121921550.11973-100000@weyl.math.psu.edu> <E14yis0-0004c9-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <E14yis0-0004c9-00@the-village.bc.nu>; from Alan Cox on Sun, May 13, 2001 at 12:32:20AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2001 at 12:32:20AM +0100, Alan Cox wrote:
> > > root@kama3:/home/szabi# cat /proc/mounts
> > > /dev/hdb2 /usr ext2 rw 0 0
> > > root@kama3:/home/szabi# swapon /dev/hdb2
> > 
> > - Doctor, it hurts when I do it!
> > - Don't do it, then.
> > 
> > Just what behaviour had you expected?
> 
> EBUSY would be somewhat nicer.

I suppose the return will be EINVAL when there is no swap signature.
But the mistake is doing set_blocksize too early. (Even twice. Why?)
We should first check whether things are OK before starting to make changes.

Andries
