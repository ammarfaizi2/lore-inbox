Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290217AbSAOR4I>; Tue, 15 Jan 2002 12:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290221AbSAORzu>; Tue, 15 Jan 2002 12:55:50 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:8382 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S290212AbSAORyZ>; Tue, 15 Jan 2002 12:54:25 -0500
Date: Tue, 15 Jan 2002 10:54:18 -0700
Message-Id: <200201151754.g0FHsIT13693@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: wichert@cistron.nl (Wichert Akkerman)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE][PATCH] New fs to control access to system resources
In-Reply-To: <a21pfj$amj$1@picard.cistron.nl>
In-Reply-To: <87k7uj61tk.fsf@tigram.bogus.local>
	<200201151653.g0FGrlG12428@vindaloo.ras.ucalgary.ca>
	<a21pfj$amj$1@picard.cistron.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wichert Akkerman writes:
> In article <200201151653.g0FGrlG12428@vindaloo.ras.ucalgary.ca>,
> Richard Gooch  <rgooch@ras.ucalgary.ca> wrote:
> >Having to set the permissions like this on each boot seems a bit
> >painful. Why not have permissions persistence like devfs has?
> 
> Maybe you could abstract that persistency from devfs and move
> it into a general layer that other filesytems can also use.

I suggested that last week in another thread (about Yet Another
Virtual FS), and heard a deafening silence. I'm not sure if it's
easier to provide a general layer, or to just make things available
via devfs. Having a general layer implies multiple persistence daemons
(aka devfsd), one for each virtual FS with persistence.

I was hoping to start some discussion about this, but it seems people
care more about Aunt Tilly :-)

I'm sure some people will scream at the top of their lungs against the
idea of making other information available via devfs, but maybe some
of those screams will be muffled once I release v2.0 of the devfs core
(that's the one where the internal tree is ripped out and the dcache
is used instead: should be a big code reduction). At least with v1.9
of the devfs core all known races have been removed, so hopefully that
softens the resistance :-)

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
