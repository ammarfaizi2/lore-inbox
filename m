Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272755AbTHEVyG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 17:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272846AbTHEVyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 17:54:06 -0400
Received: from bozo.vmware.com ([65.113.40.130]:31492 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S272755AbTHEVx6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 17:53:58 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [2.6] Perl weirdness with ext3 and HTREE
Date: Tue, 5 Aug 2003 14:53:55 -0700
Message-ID: <68F326C497FDB743B5F844B776C9B1460976FD@pa-exch4.vmware.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6] Perl weirdness with ext3 and HTREE
Thread-Index: AcNbhwhs10btucCaSGSTaBRwBprVrQABF7bQ
From: "Christopher Li" <chrisl@vmware.com>
To: <azarah@gentoo.org>
Cc: "KML" <linux-kernel@vger.kernel.org>, <akpm@digeo.com>,
       <adilger@clusterfs.com>, <ext3-users@redhat.com>,
       <x86-kernel@gentoo.org>
X-OriginalArrivalTime: 05 Aug 2003 21:53:55.0299 (UTC) FILETIME=[10E53B30:01C35B9C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Martin Schlemmer [mailto:azarah@gentoo.org]
> Sent: Tuesday, August 05, 2003 12:23 PM
> To: Christopher Li
> Cc: KML; akpm@digeo.com; adilger@clusterfs.com; ext3-users@redhat.com;
> x86-kernel@gentoo.org
> Subject: Re: [2.6] Perl weirdness with ext3 and HTREE
> 
> 
> On Tue, 2003-08-05 at 20:28, Christopher Li wrote:
> > I can take a look at it.
> > 
> > Is there any way to reproduce this bug without installing the
> > whole gentoo? It would be nice if I can just download some
> > package to make it happen.
> > 
> 
> I cannot really see that it is a Gentoo specific problem, but 
> who knows.
> I will try to get a CD of another distro somewhere, and get that on a
> box to test - currently work/whatnot just keeps me pretty tied up :(
> Another reason why I posted, is now that 2.6 is more widely 
> used/tested,
> its not only me that gets this, but other users as well - thus I hoped
> that somebody with more time wanted to have a crack at it.

I am not claiming it is a gentoo issue. I just want to duplicate
this bug with minimal damage to my box.

> 
> Back to the problem - on the same system, a 2.4 kernel works fine, but
> a 2.5/6 kernel activates a race that creates an invalid 
> entry.  I guess
> the primary reason why not many people see this, is because most
> non-Gentoo folk do not compile perl-5.8.0 from source.
> 
> Just grab the perl source, if you want, I can mail you the ebuild that
> should give some direction in how to compile it, or grab your local
> .spec, configure it (maybe with install location not in /), and then
> just compile and finally install to a ext3 FS with HTREE enabled. 
> Usually over here, it keeps on leaving an invalid entry to
> ..usr/share/man/man3/Hash::Util.tmp.

OK, I will try the perl install first.

> 
> If it works fine (with a 2.6 kernel), I will go and bang my 
> head against
> a wall, and shutup until I can make time to try and track 
> this - if not,
> any ideas as to creating it outside the perl install (or 
> rather the man
> page part of the install process) would be great.
> 

You can do a strace on the perl install, then grep for all
the file changes happen on that directory. There is a good
chance follow the strace log can duplicate the bug also.

Thanks

Chris

> 
> 


