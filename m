Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266600AbRGGWEu>; Sat, 7 Jul 2001 18:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266595AbRGGWEk>; Sat, 7 Jul 2001 18:04:40 -0400
Received: from barbados.bluemug.com ([63.195.182.101]:26884 "EHLO
	barbados.bluemug.com") by vger.kernel.org with ESMTP
	id <S266598AbRGGWEY>; Sat, 7 Jul 2001 18:04:24 -0400
Date: Sat, 7 Jul 2001 15:04:22 -0700
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Acpi] Re: ACPI fundamental locking problems
Message-ID: <20010707150422.D19529@mayotte>
Mail-Followup-To: miket, Jamie Lokier <lk@tantalophile.demon.co.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0107040956310.1668-100000@penguin.transmeta.com> <9i6oga$jk1$1@pccross.average.org> <3B46F3CE.9002ABAB@mandrakesoft.com> <20010707144032.C19529@mayotte> <20010707235329.A10256@pcep-jamie.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010707235329.A10256@pcep-jamie.cern.ch>
X-PGP-ID: 5C09BB33
X-PGP-Fingerprint: C518 67A5 F5C5 C784 A196  B480 5C97 3BBD 5C09 BB33
From: Mike Touloumtzis <miket@bluemug.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 07, 2001 at 11:53:29PM +0200, Jamie Lokier wrote:
> Mike Touloumtzis wrote:
> > 
> > Would it be possible to use a cramfs image in vmlinux (i.e. real
> > filesystem image, not an in-kernel-structures fs like ramfs), and map
> > it directly from the kernel image (it would have to be suitably aligned,
> > of course)?
> > 
> > This would allow demand paging of files in the image (not too important
> > for a minimal boot fs, admittedly), and would allow text pages to be
> > dropped under VM pressure (nice for a fs which holds substantial amounts
> > of boot-time-only code).
> 
> Yes that would work, and it would work on machines with less RAM too.
> You would want to remove the cramfs filesystem code when you're done though.

Some of the files in the boot time FS would need to
be kept around, such as the ACPI code, right?

miket
