Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285108AbRLLJEb>; Wed, 12 Dec 2001 04:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285110AbRLLJEY>; Wed, 12 Dec 2001 04:04:24 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:57871 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S285108AbRLLJEO>; Wed, 12 Dec 2001 04:04:14 -0500
Message-ID: <3C171D92.317ABE42@idb.hist.no>
Date: Wed, 12 Dec 2001 10:04:18 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.1-pre6 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: "M. Edward Borasky" <znmeb@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.16 memory badness (fixed?)
In-Reply-To: <HBEHIIBBKKNOBLMPKCBBOEHNEDAA.znmeb@aracnet.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"M. Edward Borasky" wrote:
> 
> > -----Original Message-----
> > I just can't understand why the kernel wouldn't tag application memory
> > as being more important than buff/cache and free up some of that stuff
> > when an application calls for it. I mean, it won't even use the gobs of
> > swap I have. That just seems to be a plain ol' bug to me.
> 
> It's not strictly a bug ... it's a design decision that has unfortunate
> consequences. A simple fix would be to allow the system administrator to set
> an upper limit on the size of the page cache.

I'd say he has found a bug.  Merely prioritizing cache over apps
so apps go to swap is a design desicion.  Killing the app
for OOM reasons when there is free swap and/or cache
that can be freed up _is_ a bug. 

Helge Hafting
