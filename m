Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268311AbUIGPmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268311AbUIGPmt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 11:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268184AbUIGPmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 11:42:32 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:15334 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S268311AbUIGPjh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 11:39:37 -0400
Date: Tue, 7 Sep 2004 17:39:36 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: harry_b@mm.st
Cc: James Bourne <jbourne@hardrock.org>, linux-kernel@vger.kernel.org
Subject: Re: initrd missing TTY
Message-ID: <20040907153936.GD19354@MAIL.13thfloor.at>
Mail-Followup-To: harry_b@mm.st, James Bourne <jbourne@hardrock.org>,
	linux-kernel@vger.kernel.org
References: <D41AD36206E266D4B00EBFCD@[192.168.1.247]> <Pine.LNX.4.58.0409010749510.6483@rio.clgy.hardrock.org> <1B1B394B2B14C4B2DA3856C1@[192.168.1.247]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1B1B394B2B14C4B2DA3856C1@[192.168.1.247]>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2004 at 03:59:49PM +0200, harry_b@mm.st wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi,
> 
> - --On Wednesday, September 01, 2004 07:53:13 -0600 James Bourne 
> <jbourne@hardrock.org> wrote:
> 
> >> I am not sure where to ask this question but I hope this is the right
> >> place.
> >>
> >> I am trying to setup an encrypted root partition where the key is stored
> >> gpg-encrypted on an USB memorystick. So far everything works quite
> >> nicely  but I fail to get a TTY working in the initial RAM disk.
> >>
> >> All I get is gpg complaining:
> >> gpg: cannot open '/dev/tty': No such device or address

sounds like the tty driver is either not loaded or
not compiled in at all ... but maybe I'm completely 
wrong here ...

HTH,
Herbert

> >> Any idea what's necessary to get a TTY within the RAM disk? Or is there
> >> any  other way to pass a passphrase to gpg without displaying it on the
> >> screen? (yes, I know about the --no-tty and --passphrase-fd options but
> >> when I use  /dev/console the passphrase is visible)
> >
> > make sure /dev/tty exists on your initrd image.  You can created this by
> > mounting your initrd image, changing to the dev directory on that image
> > and running mknod -m 644 tty c 5 0.
> 
> I have all devices available. Right now I have udev running but I also 
> tried a fully populated static /dev directory.
> 
> My current tty looks quite normal like
> crw-rw-rw- 1 0 0 5, 0 Sep 1 12:10 /dev/tty
> and tty1, tty2 have
> crw-rw-rw- 1 0 0 4, 1 Sep 1 12:10 /dev/tty1
> crw-rw-rw- 1 0 0 4, 2 Sep 1 12:10 /dev/tty2
> ...
> 
> Harry
> 
> - --
> 
> 1024D/40F14012 18F3 736A 4080 303C E61E  2E72 7E05 1F6E 40F1 4012
> 
> - -----BEGIN GEEK CODE BLOCK-----
> Version: 3.12
> GIT/S dx s: a C++ ULS++++$ P+++ L+++$ !E W++ N+ o? K? !w !O !M
> V PS+ PE Y? PGP+++ t+ 5-- X+ R+ !tv b++ DI++ D+ G e* h r++ y++
> - ------END GEEK CODE BLOCK------
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.5 (GNU/Linux)
> 
> iD8DBQFBNdXVfgUfbkDxQBIRApz2AKCfReZz9d7a7XWKXqYTVG25K4pShQCfQ6jT
> ndXd09GQGN+yLNp1sizUotM=
> =QK72
> -----END PGP SIGNATURE-----
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
