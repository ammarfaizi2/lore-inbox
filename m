Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129790AbQLAXPD>; Fri, 1 Dec 2000 18:15:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129891AbQLAXOx>; Fri, 1 Dec 2000 18:14:53 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:20740 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129790AbQLAXOn>; Fri, 1 Dec 2000 18:14:43 -0500
Date: Fri, 1 Dec 2000 16:44:02 -0600
To: "T. Camp" <campt@openmars.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mutliple root devs (take II)
Message-ID: <20001201164402.B25464@wire.cadcamlab.org>
In-Reply-To: <Pine.LNX.4.21.0012010843470.4856-100000@magic.skylab.org> <20001201163525.A25464@wire.cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001201163525.A25464@wire.cadcamlab.org>; from peter@cadcamlab.org on Fri, Dec 01, 2000 at 04:35:25PM -0600
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[I wrote]
> Your patch makes it impossible, in this situation, to override the
> default root device from the syslinux command line.  A kludge to make
> it work again would be to process the root devices in reverse.

Better would be to reset the list of root devices with every 'root='
statement, rather than trying all of them as you do now.  I.e.

  ... root=/dev/hda1 ... root=/dev/hda2,/dev/hda3 ...

would *not* try hda1.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
