Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130389AbQLGGwV>; Thu, 7 Dec 2000 01:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130387AbQLGGwC>; Thu, 7 Dec 2000 01:52:02 -0500
Received: from adsl-63-194-89-126.dsl.snfc21.pacbell.net ([63.194.89.126]:34052
	"HELO skull.piratehaven.org") by vger.kernel.org with SMTP
	id <S129464AbQLGGvz>; Thu, 7 Dec 2000 01:51:55 -0500
Date: Wed, 6 Dec 2000 22:16:39 -0800
From: Brian Pomerantz <bapper@piratehaven.org>
To: Peter Samuelson <peter@cadcamlab.org>
Cc: Reto Baettig <baettig@scs.ch>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: 64bit offsets for block devices ?
Message-ID: <20001206221639.A18257@skull.piratehaven.org>
Mail-Followup-To: Peter Samuelson <peter@cadcamlab.org>,
	Reto Baettig <baettig@scs.ch>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
In-Reply-To: <3A2E5227.693121F@scs.ch> <20001206220757.N6567@cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <20001206220757.N6567@cadcamlab.org>
X-homepage: http://www.piratehaven.org/~bapper/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2000 at 10:07:57PM -0600, Peter Samuelson wrote:
> 
> > Don't you think that we will run into problems anyway because soon
> > there will be raid systems with a couple of Terrabytes of space to
> > waste for mp3's ;-)
> 
> A couple of terabytes is fine.  That's 32 bits of blocks.  *More* than
> that, now, we've got a problem.
> 

Which is exactly what we're going to be dealing with "real soon now".
I'm going to be putting together a RAID system with between 1.7-5.1TB
by February.  This will be seen as a single block device to clients
via a network block device (more than likely it will be 16 Ciprico
Rimfire 7000's spread across 4 nodes via a Quadrics switch).  So, what
I'm seeing right now is that I won't be able to address this amount of
space with a single block device.  By the summer of 2001 we could be
looking at putting together 10-150TB (depends on budget and need) of
disk space for a production cluster and it would be nice if our
parallel filesystem could span that entire space with a single image.

That being said, has anyone started making changes to accommodate large
devices like this in the block layer, at least on 64bit architectures?
I don't think we are seriously considering anything other than Alphas
at this point.


BAPper
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
