Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278522AbRKFHTR>; Tue, 6 Nov 2001 02:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278566AbRKFHTH>; Tue, 6 Nov 2001 02:19:07 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:40380 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S278522AbRKFHTE>; Tue, 6 Nov 2001 02:19:04 -0500
Date: Tue, 6 Nov 2001 00:19:01 -0700
Message-Id: <200111060719.fA67J1j21018@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: alain@linux.lu, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Poor floppy performance in kernel 2.4.10 
In-Reply-To: <Pine.GSO.4.21.0110271407570.21545-100000@weyl.math.psu.edu>
In-Reply-To: <200110271800.f9RI0M803440@hitchhiker.org.lu>
	<Pine.GSO.4.21.0110271407570.21545-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> On Sat, 27 Oct 2001, Alain Knaff wrote:
> > Good. But then, what's the point of devfs=only ? I assumed this was
> 
> Ask Richard.  Maybe you will be able to get a straight answer.  I
> hadn't...

IIRC that I've told you this already. Here it is again: devfs=only
serves as a way of enforcing that the devfs entry->driver ops
connection is the only way of accessing a driver. It deliberately
breaks the fallback to major-table-lookup.

And it actually works now. It doesn't require massive 2.5 changes.
When I boot with devfs=only (which is always), my system still works.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
