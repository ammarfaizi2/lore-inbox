Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129415AbQLBEyI>; Fri, 1 Dec 2000 23:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129464AbQLBEx6>; Fri, 1 Dec 2000 23:53:58 -0500
Received: from rocko.intermag.com ([216.218.196.2]:528 "EHLO
	rocko.intermag.com") by vger.kernel.org with ESMTP
	id <S129415AbQLBExw>; Fri, 1 Dec 2000 23:53:52 -0500
Date: Fri, 1 Dec 2000 20:18:46 -0800
From: Jamie Manley <jamie@homebrewcomputing.com>
To: Peter Samuelson <peter@cadcamlab.org>
Cc: John Levon <moz@compsoc.man.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18pre24 and drm/agpgart static?
Message-ID: <20001201201846.B13358@homebrewcomputing.com>
In-Reply-To: <20001129203752.A15218@homebrewcomputing.com> <Pine.LNX.4.21.0012011450270.1317-100000@mrworry.compsoc.man.ac.uk> <20001201175153.B11780@homebrewcomputing.com> <20001201212222.D25464@wire.cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001201212222.D25464@wire.cadcamlab.org>; from peter@cadcamlab.org on Fri, Dec 01, 2000 at 09:22:22PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2000 at 09:22:22PM -0600, Peter Samuelson wrote:
> 
> [Jamie Manley]
> > Yes, modversions was enabled.  Should that be affecting the build of
> > the kernel proper?
> 
> The bug you ran into is that MODVERSIONS messes up the
> 'get_module_symbol' function, which is a sort of "optional dependency"
> mechanism used by a few modules such as DRI (in this case: DRI needs to
> be able to use the facilities of agpgart, but should also work
> *without* agpgart present, since many systems have PCI video cards).

Of course, PCI and DRI shouldn't be mutually exclusive.  Glad to hear
it's being worked on.

> 
> MODVERSIONS is ugly and gross for any number of reasons, but the
> get_module_symbol problem is quite localized -- AGP/DRI, MTD and maybe
> one or two other subsystems.  In any case it has been replaced by a
> much better inter-module registration system in 2.4.
> 
> Peter

I guess that means I should start testing 2.4.0test* on this machine
:)  Thanks for the background.

Jamie

-- 
Jamie					        http://www.intermag.com
And I said, "This must be the place." -- Laurie Anderson, "Big Science"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
