Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265360AbUGITBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265360AbUGITBi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 15:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265370AbUGITBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 15:01:38 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:32178 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265360AbUGITBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 15:01:35 -0400
From: jmerkey@comcast.net
To: Hans Reiser <reiser@namesys.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: Ext3 File System "Too many files" with snort
Date: Fri, 09 Jul 2004 19:01:28 +0000
Message-Id: <070920041901.1676.40EEEB880003599F0000068C2200763704970A059D0A0306@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Jun 24 2004)
X-Authenticated-Sender: am1lcmtleUBjb21jYXN0Lm5ldA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hans,

I forgot to mention I am running on Suse 9.1 with 2.6.4 but can upgrade this software 
to 2.6.whatever.  If you could hand me a patch or some instructions as to which files
to modify, I'll attempt to make these changes and test them.  Reiser seems a little more
complex than most of the other FS's and I am somewhat hesitant to alter it and place 
it into a production system based on a lot of bug reports I;ve seen over the years.  It's 
very powerful, but also very complex and I probably **WILL** break something if I 
attempt to change your code.  Can you point me to where the changes and/or send 
me a simple patch to remove the 32000 directory limitation and increase support to 32
bit the the nlink field?

Danke,

Jeff


> >
> Just use reiser4 which has disk format plugins.  reiserfs v3 should stay 
> stable and undisturbed.
> 

I was actually looking through your code when this message arrived.   I am 
sending out 
another unit Monday to the site installed with reiser and Suse Linux, Might I 
suggest 
perhaps you consider making the change in reiser for the larger field size to 32 
bit (I 
am looking at the code at present, and it appears you are using the same inode 
structure as everyone else) and I will default these systems to reiser instead 
of EXT3 
for this application.  There's another FS (not NWFS) that actually writes the 
captured
network traffic streaming to the system at over 400 MB/S which folks haven't 
seen 
yet, it acts more like on on-disk LRU with huge cache units (137 MB each) 
but snort and the network forensic applications use a standard file system for 
reporting.  Reiser is a good choice if this limitation can be removed.

Veil Erfolg and Gluck.  

Danke,

Jeff

Bitte 



> >Jeff  
> >  
> >
> >>-Andi
> >>
> >>    
> >>
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >
> >
> >  
> >
> 
