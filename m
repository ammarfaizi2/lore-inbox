Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266590AbUHBOkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266590AbUHBOkx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 10:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266575AbUHBOko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 10:40:44 -0400
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:55452 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266548AbUHBOi0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 10:38:26 -0400
From: tabris <tabris@tabris.net>
To: Jens Axboe <axboe@suse.de>
Subject: Re: ide-cd problems
Date: Mon, 2 Aug 2004 10:38:16 -0400
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       arklinux-list <arklinux-list@arklinux.org>
References: <20040730193651.GA25616@bliss> <200408020945.05297.tabris@tabris.net> <20040802135615.GX10496@suse.de>
In-Reply-To: <20040802135615.GX10496@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200408021038.17268.tabris@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 02 August 2004 9:56 am, Jens Axboe wrote:
> On Mon, Aug 02 2004, tabris wrote:
> > On Sunday 01 August 2004 11:57 am, Jens Axboe wrote:
> > > On Sun, Aug 01 2004, Alexander E. Patrakov wrote:
> > > > Zinx Verituse wrote:
<snip>
> > > Don't ever use that interface, period. It's not just the cdrecord
> > > code that may be alpha (I doubt it matters, it's easy to use),
> > > the interface it uses is not worth the lines of code it occupies.
> >
> > 	Then we have a severe disagreement between the cdrecord code (or
> > at least the runtime warnings) and the Linux-Kernel IDE folks.
> > specifically, these lines, while running with cdrecord
> > dev=/dev/cdrom
<snip>
> Warning: Open by 'devname' is unintentional and not supported.
>
> just says that open-by-device name is unintentional, it doesn't give
> you warnings on the transport.
>
> So in short (and repeating): don't use ATAPI (CDROM_SEND_PACKET), it
> sucks. Use SG_IO (which means using open-by-device, which works at
> least as well as the stupid faked ATAPI bus/id/lun crap and has the
> much better transport). Don't compare apples and oranges.
I'll take your point on the technical merits.

But now I get to wondering what to do about all the old HOWTOs. the 
cdrecord folks aren't helping.

	Maybe instead what should be done is a BIG FAT WARNING in the syslog? 
that the CDROM_SEND_PACKET interface is deprecated in kernel 2.6? I 
know that I personally can listen and take your advice, but I worry 
more about the rest of the users, who either will not hear, or will 
hear too many conflicting things. Perhaps it won't help, but I'd really 
like to be able to sell this stuff. And among the necessary things is 
to be able to have sane warnings, and not have warnings that will scare 
my customers off!

	Yes, this isn't really your (you==Jens) problem, but probably the 
distro maintainers (cc:d ArkLinux) to put in patches silencing some of 
these warnings, and/or change the default behaviour of their front-end 
tools.

	I merely hope to find some sanity. Though I have a feeling I'm looking 
in the wrong places (Free and Open Source).

- --
tabris
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBDlHY1U5ZaPMbKQcRAnrhAJwPM+sSRInlRy5kmpqQ+nlwS+1D5QCbBZc6
8NsRqRQqLddQgY8FuCzEvck=
=BhCR
-----END PGP SIGNATURE-----
