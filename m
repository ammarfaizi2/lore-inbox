Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317083AbSHBTnB>; Fri, 2 Aug 2002 15:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317112AbSHBTnB>; Fri, 2 Aug 2002 15:43:01 -0400
Received: from barbados.bluemug.com ([63.195.182.101]:58892 "EHLO
	barbados.bluemug.com") by vger.kernel.org with ESMTP
	id <S317083AbSHBTnA>; Fri, 2 Aug 2002 15:43:00 -0400
Date: Fri, 2 Aug 2002 12:40:58 -0700
To: Alexander Viro <viro@math.psu.edu>
Cc: martin@dalecki.de, Thunder from the hill <thunder@ngforever.de>,
       Peter Chubb <peter@chubb.wattle.id.au>, Pavel Machek <pavel@ucw.cz>,
       Matt_Domsch@Dell.com, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.28 and partitions
Message-ID: <20020802194058.GA4528@bluemug.com>
Mail-Followup-To: Alexander Viro <viro@math.psu.edu>, martin@dalecki.de,
	Thunder from the hill <thunder@ngforever.de>,
	Peter Chubb <peter@chubb.wattle.id.au>, Pavel Machek <pavel@ucw.cz>,
	Matt_Domsch@Dell.com, Andries.Brouwer@cwi.nl,
	linux-kernel@vger.kernel.org
References: <3D49A75D.801@evision.ag> <Pine.GSO.4.21.0208011733450.12627-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0208011733450.12627-100000@weyl.math.psu.edu>
X-PGP-ID: 5C09BB33
X-PGP-Fingerprint: C518 67A5 F5C5 C784 A196  B480 5C97 3BBD 5C09 BB33
From: Mike Touloumtzis <miket@bluemug.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2002 at 05:41:53PM -0400, Alexander Viro wrote:
> 
> On Thu, 1 Aug 2002, Marcin Dalecki wrote:
> 
> > Ahh. we are at "devil" arguemnt level... So I will ease myself:
> > Why the hell don't you rewrite the whole kernel for example in LISP if
> > you love string processing that much?
> 
> Huh?
> 
> What the <your pet expletive> does LISP have to strings?

Umm... LISP is all about using strings instead of binary representations,
or at least hiding binary representations other than list building
primitives from the programmer.

Your ASCII partition table proposal is _exactly_ what a LISPer would
propose for partition tables: use strings to represent values in a format
that has no implicit size limits on numbers, is endian independent, etc.
The only difference is a LISPer would surround it with parentheses :-).

IMHO s-expressions are severely underrepresented as an
architecture-independent data representation that could more or less
eliminate the need for ad hoc parsers in, say, /proc.  Of course
one-ASCII-symbol-per-file accomplishes more or less the same thing,
but for much higher system call overhead.  I guess the ideal would be a
multi-file-spanning variation on seq_file (I think that's the name for
the stateful /proc parsing helper?) that would serialize the contents
of a tree into an s-expression, allowing the best of both worlds.

miket
