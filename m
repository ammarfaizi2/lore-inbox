Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271934AbRIDKZU>; Tue, 4 Sep 2001 06:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271933AbRIDKZK>; Tue, 4 Sep 2001 06:25:10 -0400
Received: from d179.dhcp212-198-121.noos.fr ([212.198.121.179]:19987 "EHLO
	microsoft.com") by vger.kernel.org with ESMTP id <S271931AbRIDKYw>;
	Tue, 4 Sep 2001 06:24:52 -0400
Subject: Re: [RFD] readonly/read-write semantics
From: Xavier Bestel <xavier.bestel@free.fr>
To: Alexander Viro <viro@math.psu.edu>
Cc: Jean-Marc Saffroy <saffroy@ri.silicomp.fr>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Bryan Henderson <hbryan@us.ibm.com>, linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <Pine.GSO.4.21.0109040612300.26423-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0109040612300.26423-100000@weyl.math.psu.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99+cvs.2001.08.22.00.33 (Preview Release)
Date: 04 Sep 2001 12:20:28 +0200
Message-Id: <999598828.11178.8.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On mar, 2001-09-04 at 12:15, Alexander Viro wrote:
> 
> 
> On 4 Sep 2001, Xavier Bestel wrote:
> 
> > On mar, 2001-09-04 at 06:09, Alexander Viro wrote:
> > 
> > > Read-only is more complex - in addition to mount side ("does anyone want
> > > it to be r/w") there is a filesystem side ("does fs agree to be r/w")...
> > 
> > How about, say, a reiserfs mounted r/o on a shared partition (loopback
> > over nfs) ? If it contains errors, maybe 2 "clients" will attempt to
> > rollback at the same time. Is the solution to never mount, even r/o,
> > remote journalling fs ?
> 
> ??? Rollback is purely local thing, so NFS client doesn't matter at all.
> And nfsd is just an application running on server, whether it's a kernel
> thread or a normal process.

Sorry, I meant journal replaying ... AFAIK, this operation will write on
the media even if mounted r/o.

Xav
