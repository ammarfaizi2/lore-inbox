Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291717AbSBTKLp>; Wed, 20 Feb 2002 05:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291718AbSBTKLe>; Wed, 20 Feb 2002 05:11:34 -0500
Received: from natpost.webmailer.de ([192.67.198.65]:52393 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S291717AbSBTKLV>; Wed, 20 Feb 2002 05:11:21 -0500
Date: Wed, 20 Feb 2002 11:05:28 +0100
From: Kristian <kristian.peters@korseby.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, andre@linux-ide.org
Subject: Re: 2.4.18-pre9-ac4 filesystem corruption
Message-Id: <20020220110528.4274e61d.kristian.peters@korseby.net>
In-Reply-To: <E16dBaR-0000fj-00@the-village.bc.nu>
In-Reply-To: <20020219153248.39a1b7fc.kristian.peters@korseby.net>
	<E16dBaR-0000fj-00@the-village.bc.nu>
X-Mailer: Sylpheed version 0.7.1claws7 (GTK+ 1.2.10; i386-redhat-linux)
X-Operating-System: Debian GNU/Linux 2.4.17
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > memtest86 completed successfully.
> > I'll test with -rc2-ac1 for ext2 corruption again.
> 
> Thanks. If you do see it can you test with ide=nodma as well and see what
> that does. Andre will probably also want to know how long your IDE cables
> are 8)

Booting just normal with -rc2-ac1:

Directly after boot appears this messages again:
	init_special_inode: bogus imode (70141) 
I'd had to run e2fsck -f /dev/hda5 (/) on it:
	Entry 'par2' in /dev (8166) has deleted/unused inode 9337.
But former errors occured on other partitons as well (/dev/hda(5-8)).
The cable used:
	+----------+----------------------+
	|          |                      |
	|<--16cm-->|<--------40cm-------->|
	+----------+----------------------+
    controller  WDC AC24300L          LTN301 CDROM

Booting with ide=nodma:

The corruption hasn't appeared yet.

I've also tried dd if=/dev/hda(1,5-8) of=/dev/null bs=4k without error-messages in the logs.

So I may switch back to -pre9-ac3 again and see if it happens with that kernel.

*Kristian

  :... [snd.science] ...:
 ::
 :: http://www.korseby.net
 :: http://gsmp.sf.net
  :..........................:
