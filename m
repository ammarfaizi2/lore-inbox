Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292685AbSBZSlb>; Tue, 26 Feb 2002 13:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292663AbSBZSkP>; Tue, 26 Feb 2002 13:40:15 -0500
Received: from h24-67-15-4.cg.shawcable.net ([24.67.15.4]:12785 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S292668AbSBZSeb>;
	Tue, 26 Feb 2002 13:34:31 -0500
Date: Tue, 26 Feb 2002 11:34:02 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: BK Kernel Hacking HOWTO
Message-ID: <20020226113402.K12832@lynx.adilger.int>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Linux-Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <3C751CB2.52110E58@mandrakesoft.com> <Pine.GSO.4.21.0202261842290.8085-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0202261842290.8085-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Tue, Feb 26, 2002 at 06:45:08PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 26, 2002  18:45 +0100, Geert Uytterhoeven wrote:
> So what if Linus isn't happy with the changes you made in the for-Him-to-pull
> tree? How do I back off (part of the changes)?

Well, assuming he tells you that there is a problem, run "bk undo -r <rev>.."
to remove the patchset that he doesn't like (in theory).  If there have been
a large number of changes after <rev> then they are all removed (there is no
way to remove only a single CSET from within the middle of the tree.  Then
you re-do the changes in a way that Linus likes, and submit a new CSET.

You could also add the fix to the same tree and hope he accepts both CSETs,
but I think Linus doesn't want to clutter up his tree with <patch>+<fix>
instead of a single <patch> that was correct in the first place.

In some cases, you are probably better off to export the changes in <rev>
into a diff, get a new Linus BK tree, and re-apply the patches + fixes
and generate a new CSET from that.

Not perfect, but that's life.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

