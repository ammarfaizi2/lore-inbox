Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263568AbTCUJVV>; Fri, 21 Mar 2003 04:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263567AbTCUJVV>; Fri, 21 Mar 2003 04:21:21 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:41476 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S263568AbTCUJVS>; Fri, 21 Mar 2003 04:21:18 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200303210933.h2L9XmiZ000401@81-2-122-30.bradfords.org.uk>
Subject: Re: Release of 2.4.21
To: sflory@rackable.com (Samuel Flory)
Date: Fri, 21 Mar 2003 09:33:48 +0000 (GMT)
Cc: akpm@digeo.com, hch@infradead.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
In-Reply-To: <3E7A6B4F.1000205@rackable.com> from "Samuel Flory" at Mar 20, 2003 05:30:55 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>>>For critical fixes, release a 2.4.20.1, 2.4.20.2, etc.  Don't disrupt
> >>>>the 2.4.21-pre cycle, that would be less productive than just patching
> >>>>2.4.20 and rolling a separate release off of that.
> >>>>        
> >>>>
> >>>I think the naming is illogical.  If there's a bugfix-only release
> >>>it whould have normal incremental numbers.  So if marcelo want's
> >>>it he should clone a tree of at 2.4.20, apply the essential patches
> >>>and bump the version number in the normal 2.4 tree to 2.4.22-pre1
> >>>      
> >>>
> >>No point in making things too complex.  2.4.20-post1 is something people can
> >>easily understand.
> >>
> >>I needed that for the ext3 problems which popped up shortly after 2.4.20 was
> >>released - I was reduced to asking people to download fixes from my web page.
> >>
> >>And having a -post stream may allow us to be a bit more adventurous in the
> >>-pre stream.
> >>    
> >>
> >
> >Why can't we just make all releases smaller and more frequent?
> >
> >Why do we need 2.4.x-pre at all, anyway - why can't we just test
> >things in the -[a-z][a-z] trees, and _start_ with -rc1?
> >
> >Why can't we just do bugfixes for 2.4, and speed up 2.5 development?
> >
> >  
> >
> 
>   That would imply some changes could take place in a short cycle.  This 
> is not true for things like major ide subsystem updates.

We should not have major updates like that as a regular occurance in
the stable kernel series.  If they are necessary, we could break with
the small, frequent updates, and go back to what we have now.

Why can't we basically have two modes of working:

* When nothing major is being re-written:

Small, frequent updates.  -pre and -rc version numbering used to
indicate kernels which haven't had much testing.  Larger updates
existing in -[a-z][a-z] trees.


* When an update to a core subsystem is in progress

Larger, less frequent updates.  -pre and -rc versions getting more
testing, and -[a-z][a-z] trees for very experimental code.


I know there are frequently suggestions about how to organise kernel
development, and they are usually ignored, because we generally don't
like to work however we want to, but this suggestion is just common
sense.  When nothing much is going on, release smaller changes to get
a lot of testing of the same codebase.  When major work is going on,
separate out the minor updates to give people flexibility in testing.

John.
