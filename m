Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132302AbRAYS1v>; Thu, 25 Jan 2001 13:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135654AbRAYS1l>; Thu, 25 Jan 2001 13:27:41 -0500
Received: from pcep-jamie.cern.ch ([137.138.38.126]:28169 "EHLO
	pcep-jamie.cern.ch") by vger.kernel.org with ESMTP
	id <S132302AbRAYS13>; Thu, 25 Jan 2001 13:27:29 -0500
Date: Thu, 25 Jan 2001 19:27:21 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org, tmolina@home.com
Subject: Re: problem with dd for floppy under 2.4.0
Message-ID: <20010125192721.C5109@pcep-jamie.cern.ch>
In-Reply-To: <200101231208.NAA29008@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200101231208.NAA29008@harpo.it.uu.se>; from mikpe@csd.uu.se on Tue, Jan 23, 2001 at 01:08:54PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> There's a known bug in dd where it incorrectly attempts to truncate
> the output file even though it's a block device.

dd also attempts to truncate a character device, therefore fails in the
same way.

The kernel should probably return EINVAL for this rather than EPERM.

> In kernels older
> than 2.4.0-test10 or so it got away with this, but now the kernel
> correctly returns an error.
> 
> Use the 'conv=notrunc' option to dd to fix this, i.e.
> 
>     dd if=rootfs.gz of=/dev/fd0 bs=1k conv=notrunc seek=XXX

If only it were so easy to fix the program that calls dd...

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
