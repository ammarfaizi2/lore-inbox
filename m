Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129642AbQKEKsF>; Sun, 5 Nov 2000 05:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129780AbQKEKr6>; Sun, 5 Nov 2000 05:47:58 -0500
Received: from rigel.cs.pdx.edu ([131.252.208.59]:30181 "EHLO rigel.cs.pdx.edu")
	by vger.kernel.org with ESMTP id <S129642AbQKEKrr>;
	Sun, 5 Nov 2000 05:47:47 -0500
Date: Sun, 5 Nov 2000 02:47:44 -0800 (PST)
From: Naren Devaiah <naren@cs.pdx.edu>
To: Tigran Aivazian <tigran@veritas.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Where is __this_module actually defined?
In-Reply-To: <Pine.LNX.4.21.0011051041310.1171-100000@saturn.homenet>
Message-ID: <Pine.GSO.4.21.0011050245280.2808-100000@antares.cs.pdx.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Does this mean that the module structure (struct module) and it's various
substructures are filled in by insmod?

Regards,
Naren

On Sun, 5 Nov 2000, Tigran Aivazian wrote:

> On Sun, 5 Nov 2000, Naren Devaiah wrote:
> 
> > 
> > I've looked in the 2.4.0-pre10 source tree and found it defined as 
> > 	extern struct module __this_module;
> > in module.h (among other files), but where is it actually defined?
> > 
> 
> it isn't -- it's magic, of course :). The way it works is for insmod to
> arrange things in such a manner that &__this_module resolves to point to
> the beginning of module's address space, which happens to contain 'struct
> module' at the beginning.
> 
> Regards,
> Tigran
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
