Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129899AbRBYGNL>; Sun, 25 Feb 2001 01:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129893AbRBYGNC>; Sun, 25 Feb 2001 01:13:02 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:54913 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129885AbRBYGMn>;
	Sun, 25 Feb 2001 01:12:43 -0500
Date: Sun, 25 Feb 2001 01:12:42 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "David L. Nicol" <david@kasey.umkc.edu>
cc: Peter Samuelson <peter@cadcamlab.org>, Wakko Warner <wakko@animx.eu.org>,
        linux-kernel@vger.kernel.org
Subject: Re: OK to mount multiple FS in one dir?
In-Reply-To: <3A81D0E5.B9F3794E@kasey.umkc.edu>
Message-ID: <Pine.GSO.4.21.0102250110580.24871-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Feb 2001, David L. Nicol wrote:

> Peter Samuelson wrote:
>  
> > A more useful thing to fall out of the same hacking is loopback
> > mounting -- i.e. the same filesystem mounted multiple places.  In
> > Linux-land I guess we call it 'mount --bind'.
> > 
> > Peter
> 
> Does this kind of thing play nice with nfs and coda, in terms of
> change notifications and write-backs? In distributed FS we've got
> the same thing mounted multiple places, of course, but not on the
> same machine

There is no cache coherency problems since we have no copies to keep
in sync ;-) Dentry tree is shared by all instances.

