Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271927AbRIDKP0>; Tue, 4 Sep 2001 06:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271929AbRIDKPR>; Tue, 4 Sep 2001 06:15:17 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:54943 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S271927AbRIDKPG>;
	Tue, 4 Sep 2001 06:15:06 -0400
Date: Tue, 4 Sep 2001 06:15:17 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Xavier Bestel <xavier.bestel@free.fr>
cc: Jean-Marc Saffroy <saffroy@ri.silicomp.fr>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Bryan Henderson <hbryan@us.ibm.com>, linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFD] readonly/read-write semantics
In-Reply-To: <999595577.11178.3.camel@nomade>
Message-ID: <Pine.GSO.4.21.0109040612300.26423-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 4 Sep 2001, Xavier Bestel wrote:

> On mar, 2001-09-04 at 06:09, Alexander Viro wrote:
> 
> > Read-only is more complex - in addition to mount side ("does anyone want
> > it to be r/w") there is a filesystem side ("does fs agree to be r/w")...
> 
> How about, say, a reiserfs mounted r/o on a shared partition (loopback
> over nfs) ? If it contains errors, maybe 2 "clients" will attempt to
> rollback at the same time. Is the solution to never mount, even r/o,
> remote journalling fs ?

??? Rollback is purely local thing, so NFS client doesn't matter at all.
And nfsd is just an application running on server, whether it's a kernel
thread or a normal process.

