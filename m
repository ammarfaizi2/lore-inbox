Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319167AbSHMXKj>; Tue, 13 Aug 2002 19:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319106AbSHMXJ3>; Tue, 13 Aug 2002 19:09:29 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:35581 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319155AbSHMXJV>; Tue, 13 Aug 2002 19:09:21 -0400
Subject: Re: 2.4.20-pre2 NFS OOPS on sparc64
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <15705.34786.933680.708535@notabene.cse.unsw.edu.au>
References: <Pine.GSO.4.43.0208131916340.16824-100000@romulus.cs.ut.ee>
	<20020813.102737.04335380.davem@redhat.com> 
	<15705.34786.933680.708535@notabene.cse.unsw.edu.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 14 Aug 2002 00:10:47 +0100
Message-Id: <1029280247.21007.136.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-08-13 at 23:27, Neil Brown wrote:
> On Tuesday August 13, davem@redhat.com wrote:
> >    From: Meelis Roos <mroos@linux.ee>
> >    Date: Tue, 13 Aug 2002 19:21:30 +0300 (EEST)
> > 
> >    2 oopses from stock 2.4.20-pre2 during NFS startup 9mountd etc killed as
> >    a result). Looks like a bad use of bitops inside sunrpc. egcs64 compiler
> >    from debian.
> >    
> > Neil, sk_flags in struct svc_sock may not be an int, bitops require
> > "long".
> 
> I knew that.... but obviously not at the right time.  Thanks.
> 
> Now if only Linus has told me (like you did) instead of just making
> the change himself in 2.5, I would have got it right in 2.4.

May be my fault. I fixed it in 2.2 the first time it cropped up and
apparently forgot to tell you so it propogated

