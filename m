Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264838AbSKEMhV>; Tue, 5 Nov 2002 07:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264839AbSKEMhV>; Tue, 5 Nov 2002 07:37:21 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:34525 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264838AbSKEMhU>;
	Tue, 5 Nov 2002 07:37:20 -0500
Date: Tue, 5 Nov 2002 18:15:44 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Werner Almesberger <wa@almesberger.net>
Cc: Richard J Moore <richardj_moore@uk.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       lkcd-devel@lists.sourceforge.net,
       lkcd-devel-admin@lists.sourceforge.net,
       lkcd-general@lists.sourceforge.net,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linus Torvalds <torvalds@transmeta.com>,
       "Matt D. Robinson" <yakker@aparity.com>
Subject: Re: [lkcd-devel] Re: What's left over.
Message-ID: <20021105181544.B11443@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <OFAA5C1DF6.DA161B71-ON80256C63.007D0F0E@portsmouth.uk.ibm.com> <20021031203935.Z1421@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021031203935.Z1421@almesberger.net>; from wa@almesberger.net on Thu, Oct 31, 2002 at 08:39:35PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 08:39:35PM -0300, Werner Almesberger wrote:
> Richard J Moore wrote:
> > and so do many people. In fact netdump, mcode and lkcd are all
> > complementary parts of the same need.
> 
> It's the "complementary" that worries me. Once you have mcore, what
> good are direct dumps to the network or the disk for ? With mcore,
> the whole issue of accessing stable storage is eliminated.
> 
> I don't know if the approach of having multiple quasi-equivalent
> means of storing a dump is something that Linus dislikes about
> LKCD, but I think it might be worth exploring if LKCD's chance of
> acceptance could be improved by focusing on a single but general
> mechanism.

The very question that's kept me up late some nights :)
And one of the reasons for spending so much time in integrating 
mcore seamlessly into the lkcd framework rather than plug it in 
as is at a high level. Precisely to avoid bloat while retaining 
flexibility and to move from something that works today to
more improved schemes in the future. 

The decision on what dump device implementations - block, net,
memory, and other special types to include could be a separate 
one from the base dump system, and could change as time passes.

> 
> I think it would be a pity if we ended up not having crash dumps
> in 2.6 only because they're over-featured ...

The dump driver interface is pretty simple, if you look at it
.. though it was meant to be powerful enough to do a lot of nice
things in the future. 

Regards
Suparna

> 
> - Werner
> 
> -- 
>   _________________________________________________________________________
>  / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
> /_http://www.almesberger.net/____________________________________________/
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by: Influence the future 
> of Java(TM) technology. Join the Java Community 
> Process(SM) (JCP(SM)) program now. 
> http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0004en
> _______________________________________________
> lkcd-devel mailing list
> lkcd-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/lkcd-devel

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

