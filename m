Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129050AbQKKD5X>; Fri, 10 Nov 2000 22:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129076AbQKKD5M>; Fri, 10 Nov 2000 22:57:12 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:39177 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129050AbQKKD44>; Fri, 10 Nov 2000 22:56:56 -0500
Date: Fri, 10 Nov 2000 21:56:28 -0600
To: George Anzinger <george@mvista.com>
Cc: Dan Aloni <karrde@callisto.yi.org>, Ivan Passos <lists@cyclades.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Patch generation
Message-ID: <20001110215628.A28057@wire.cadcamlab.org>
In-Reply-To: <Pine.LNX.4.21.0011100051190.31850-100000@callisto.yi.org> <3A0C2813.E7CB42D2@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A0C2813.E7CB42D2@mvista.com>; from george@mvista.com on Fri, Nov 10, 2000 at 08:53:39AM -0800
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  [Dan Aloni]
> > Then you run this script (I got it when Riel pasted it on IRC)
> > 
> > for i in `find ./ -name \*.orig` ; do diff -u $i `dirname $i`/`basename $i
> > .orig` ; done

That works, but see http://bugs.debian.org/64958 for my variant: a
fairly trivial diff diff that adds a flag '-k' which lets you specify
your backup suffix, then it just takes one file|dir instead of two.

  diff -urN -Xdontdiff -k.orig {source-tree}

It's been sent to Paul Eggert (of diffutils); no word so far.

[George Anzinger]
> (I prefer EMACS, which likes to unlink.)

No it doesn't, not always.  Your choice:

  (setq make-backup-files nil)
  (setq backup-by-copying t)

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
