Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289369AbSAJKAs>; Thu, 10 Jan 2002 05:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289368AbSAJKA3>; Thu, 10 Jan 2002 05:00:29 -0500
Received: from hera.cwi.nl ([192.16.191.8]:19961 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S289369AbSAJKAQ>;
	Thu, 10 Jan 2002 05:00:16 -0500
From: Andries.Brouwer@cwi.nl
Date: Thu, 10 Jan 2002 10:00:14 GMT
Message-Id: <UTC200201101000.KAA311551.aeb@cwi.nl>
To: ben@xmission.com, chris@void.printf.net
Subject: Re: Bigggg Maxtor drives (fwd)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2002 at 04:03:09AM +0000, Chris Ball wrote:
> On Wed, Jan 09, 2002 at 08:14:32PM -0700, Benjamin S Carrell wrote:
> > I would think that you lose that space to formatting
>
> Is this perhaps Maxtor providing their own 'non-standard'[1] definition
> of gigabyte, rather than a technical issue?
>
> [1]: (viz. 'wrong')

No, *all* disk manufacturers *always* use decimal, correctly following
the standard. And it has been like this for many years.

No, this is an entirely different phenomenenon.
In the Large Disk Howto you can read in
        http://www.win.tue.nl/~aeb/linux/Large-Disk-4.html#ss4.2
about IDE limits:

ATA Specification (for IDE disks) - the 137 GB limit

    At most 65536 cylinders (numbered 0-65535), 16 heads (numbered 0-15),
    255 sectors/track (numbered 1-255), for a maximum total capacity of
    267386880 sectors (of 512 bytes each), that is, 136902082560 bytes
    (137 GB). This is not yet a problem (in 1999), but will be a few
    years from now.

And indeed, in 2001 the 137 GB limit was crossed.
In order to make addressing of larger disks possible, a new addressing
mode was introduced (in the ATA6 draft, rev 0b), that uses 48-bit
addressing (instead of 28-bit). Thus, the new limit is roughly 
a million times larger.

Thus, we need new code that implements the new addressing.
Since one only hears positive reports on Andre's patch, probably
we should take all of it, but the code for 48-bit addressing
is a small fragment that could also easily be separated out.

Andries
