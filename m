Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277723AbRJLO4A>; Fri, 12 Oct 2001 10:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277722AbRJLOzu>; Fri, 12 Oct 2001 10:55:50 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:8604 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S277721AbRJLOzh>; Fri, 12 Oct 2001 10:55:37 -0400
Date: Fri, 12 Oct 2001 08:56:05 -0600
Message-Id: <200110121456.f9CEu5j15440@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
Cc: Matt Domsch <mdomsch@Dell.com>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EFI GUID Partition Tables
In-Reply-To: <Pine.LNX.4.33.0110121026430.9327-100000@biker.pdb.fsc.net>
In-Reply-To: <200110091725.f99HPZ530405@vindaloo.ras.ucalgary.ca>
	<Pine.LNX.4.33.0110121026430.9327-100000@biker.pdb.fsc.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Wilck writes:
> Richard,
> 
> > You've put the devfs_unregister_slave() inside an #ifdef. Yuk! It
> > shouldn't be conditional.
> 
> I did that because I didn't want to pollute your code. The function
> was only needed for the UUID patch.
> 
> > And I'm not really sure that I like this
> > function in the first place, but that's not something I want to get
> > into right now.
> 
> I did not see a possibility to cleanly remove a slave that was
> registered before. Did I oversee something? Do you thing that
> functionality is superfluous?

The whole slave mechanism is a hack, created because of the badly
structured genhd layer. It's a convenience for lazy programmers (like
me, when I was hacking the genhd layer:-). I'd prefer to see it used
very sparingly.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
