Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318129AbSGWRWq>; Tue, 23 Jul 2002 13:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318136AbSGWRWq>; Tue, 23 Jul 2002 13:22:46 -0400
Received: from vger.timpanogas.org ([216.250.140.154]:20876 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S318129AbSGWRWq>; Tue, 23 Jul 2002 13:22:46 -0400
Date: Tue, 23 Jul 2002 11:03:44 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: dmarkh@cfl.rr.com, linux-kernel@vger.kernel.org
Subject: Re: bigphysarea
Message-ID: <20020723110344.A26854@vger.timpanogas.org>
References: <mailman.1027420021.27849.linux-kernel2news@redhat.com> <200207231708.g6NH80218466@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200207231708.g6NH80218466@devserv.devel.redhat.com>; from zaitcev@redhat.com on Tue, Jul 23, 2002 at 01:08:00PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



You can achieve the same thing without the bigphys patch.  I was
using the bigphys patch in the Dolphin SCI drivers, but with 
these systems having all this memory these days, just the
standard get pages calls work well enough.  To see an alternate 
implementation of bigphys that does not rely on big phys, look
at memalloc.c in the SCI code base at 

www.kernel.org/pub/linux/kernel/people/jmerkey/

and download the latest SCI drivers for Linux.  I used to use the 
bigphys patch, but found it really wasn't necessary to do what 
I needed to do.

Jeff

On Tue, Jul 23, 2002 at 01:08:00PM -0400, Pete Zaitcev wrote:
> > [...] We have been using the bigphysarea patch and seems
> > to do what we need for this card. We have been using it sice the beginning to the 2.4 
> > series kernel. My question is, is this patch still nessessary or is there possibly a
> > way do do this now without the patch?
> 
> I think Pauline never bothered to submit it. In Welsh's times
> it was considered too esoteric for inclusion, but nowdays we
> carry so much bloat that I'd think bigphysarea can be included.
> If you want it included, take over the issue and bug Linus.
> 
> -- Pete
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
