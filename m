Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129732AbQKKFRu>; Sat, 11 Nov 2000 00:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129675AbQKKFRl>; Sat, 11 Nov 2000 00:17:41 -0500
Received: from munchkin.spectacle-pond.org ([209.192.197.45]:261 "EHLO
	munchkin.spectacle-pond.org") by vger.kernel.org with ESMTP
	id <S129655AbQKKFR3>; Sat, 11 Nov 2000 00:17:29 -0500
Date: Sat, 11 Nov 2000 00:17:04 -0500
From: Michael Meissner <meissner@spectacle-pond.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Where is it written?
Message-ID: <20001111001704.B2766@munchkin.spectacle-pond.org>
In-Reply-To: <8ui698$c2q$1@cesium.transmeta.com> <11198.973906134@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <11198.973906134@ocs3.ocs-net>; from kaos@ocs.com.au on Sat, Nov 11, 2000 at 12:28:54PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2000 at 12:28:54PM +1100, Keith Owens wrote:
> On 10 Nov 2000 17:10:00 -0800, 
> "H. Peter Anvin" <hpa@zytor.com> wrote:
> >We can mess with the ABI, but it requires a wholescale rev of the
> >entire system.
> 
> AFAICT, there is nothing stopping us from redoing the kernel ABI to
> pass the first few parameters between kernel functions in registers.
> As long as the syscall interface is unchanged, that ABI change will
> only break binary modules (care_factor == 0).  The ABI type would need
> to be added to the symbol version prefix, trivial.

Other than the minor little fact that -mregparm=n exposes several latent
compiler bugs, that since it is not part of the ABI, it isn't on anybody's
radar screen as needing to be fixed.  This is of course the downside of free
software, that volunteers tend to have their own ideas of what to work on.

Also note, that for -mregpar=n, it is important that variable argument
functions be declared properly in all callers, since they need to use the
standard calling sequence.

-- 
Michael Meissner, Red Hat, Inc.
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886, USA
Work:	  meissner@redhat.com		phone: +1 978-486-9304
Non-work: meissner@spectacle-pond.org	fax:   +1 978-692-4482
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
