Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282919AbRLBRAF>; Sun, 2 Dec 2001 12:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282904AbRLBQ7r>; Sun, 2 Dec 2001 11:59:47 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:20160 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S284263AbRLBQ7i>;
	Sun, 2 Dec 2001 11:59:38 -0500
Date: Sun, 2 Dec 2001 11:59:34 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre5 not easy to boot with devfs
In-Reply-To: <3C0A025C.88B7A2C3@wanadoo.fr>
Message-ID: <Pine.GSO.4.21.0112021150310.12801-100000@binet.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 2 Dec 2001, Pierre Rousselet wrote:

> Here is the final (i hope) verdict of my devfs testbox :
> 
> 2.4.16 with devfsd-1.3.18/1.3.20 : OK
> 2.4.17-pre1         "            : Broken
> 2.5.1-pre1          "            : OK
> 2.5.1-pre2 with or without v200  : Broken
> 2.5.1-pre5          "            : Broken

IOW, merge of new devfs code (2.4.17-pre1 in -STABLE, 2.5.1-pre2 in -CURRENT).

We really need CONFIG_DEBUG_* forced if CONFIG_DEVFS_FS is set.  Otherwise
we'll be getting tons of bug reports due to silent memory corruption.

Keith, is there a decent way to do that?  For 2.4.17 it would help a lot...

