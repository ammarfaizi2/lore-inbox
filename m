Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272530AbRH3W3r>; Thu, 30 Aug 2001 18:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272531AbRH3W3h>; Thu, 30 Aug 2001 18:29:37 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:27653 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272530AbRH3W32>; Thu, 30 Aug 2001 18:29:28 -0400
Subject: Re: Reiserfs: how to mount without journal replay?
To: pavel@suse.cz (Pavel Machek)
Date: Thu, 30 Aug 2001 23:32:19 +0100 (BST)
Cc: reiser@namesys.com (Hans Reiser), Nikita@namesys.com (Nikita Danilov),
        pavel@ucw.cz (Pavel Machek), linux-kernel@vger.kernel.org,
        research@suse.de
In-Reply-To: <20010830235005.B9330@bug.ucw.cz> from "Pavel Machek" at Aug 30, 2001 11:50:05 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15caMF-00021I-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Booting from CDROM with SuSE is not such a problem.
> 
> ext2 is willing to mount ro even with known inconsistencies. SuSE 7.1
> does not come with 'live filesystem' and install cd does not have
> reiserfsck on it. Too bad. You have to install somewhere to be able to
> run reiserfsck on suse7.1.

You can get ext2 sufficiently hosed that you can't mount it or run fsck off
it as well. Ok its harder, and "-o mount_me_harder" might be useful for 
reiserfs in this situation.  

There is another reason for doing rescue without disk writeback which is
more pressing - bad disks _often_ go close to read only when they begin
to fail.

Also you need a true mount purely read only (or some kind of initrd deep
voodoo) to use ext3 or reiserfs with swsuspend

Alan
