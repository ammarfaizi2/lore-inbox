Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287752AbSAAFh7>; Tue, 1 Jan 2002 00:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287755AbSAAFht>; Tue, 1 Jan 2002 00:37:49 -0500
Received: from inreach-gw1.idiom.com ([209.209.13.26]:33542 "EHLO
	smile.idiom.com") by vger.kernel.org with ESMTP id <S287752AbSAAFhg>;
	Tue, 1 Jan 2002 00:37:36 -0500
Message-ID: <3C314A73.E94328E9@obviously.com>
Date: Tue, 01 Jan 2002 00:34:43 -0500
From: Bryce Nesbitt <bryce@obviously.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: cs@zip.com.au
CC: linux-kernel@vger.kernel.org, Lionel Bouton <Lionel.Bouton@free.fr>,
        Andries.Brouwer@cwi.nl
Subject: Re: Why would a valid DVD show zero files on Linux?
In-Reply-To: <E16L2G8-00050T-00@the-village.bc.nu> <3C307464.2253E26@obviously.com> <20020101103753.A13046@zapff.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cameron Simpson wrote:
> 
> On Mon, Dec 31, 2001 at 09:21:24AM -0500, Bryce Nesbitt <bryce@obviously.com> wrote:
> | Alan Cox wrote:
> | > The autodetection is working. Your DVD has a UDF file system on it and a
> | > blank iso9660 one.
> | Understood.   However, why can't that combination "just work"?  Changing
> | /etc/fstab every time I switch between sticking in a CD-ROM and DVD-ROM is not cool.
> | Certainly that "other operating system" does not make me do that.
> 
> I do this via autofs, and just say /mnt/dvd when I want UDF and /mnt/cdrom
> when I want a CDROM. It does depend on having my eyes open when I stick
> the medium in the drive...
> 
> Of course, this merely bypasses the autodetection.

Ok, I admit, I do the same thing.  I manually mount.  But let's get in
the head of a user, why should they care what type of 5 inch round shiny
thing they just inserted?

Are there any cases where udf filesystems are present on cdrom's that should
be read as iso9660?  Someone mentioned it's a hard heuristic to figure out
which fake filename the empty iso9660 filesystem uses.  How about, instead,
pick the larger of the two filesystems if both are present.

			-Bryce
