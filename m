Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313789AbSDZUqS>; Fri, 26 Apr 2002 16:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314144AbSDZUqR>; Fri, 26 Apr 2002 16:46:17 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:60938 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S313789AbSDZUqR>; Fri, 26 Apr 2002 16:46:17 -0400
Message-Id: <200204262042.g3QKg4X27407@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Alexander Viro <viro@math.psu.edu>, Andrew Morton <akpm@zip.com.au>
Subject: Re: [RFC] link_path_walk cleanup
Date: Fri, 26 Apr 2002 23:45:14 -0200
X-Mailer: KMail [version 1.3.2]
Cc: maneesh@in.ibm.com, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0204261318110.22065-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 April 2002 15:26, Alexander Viro wrote:
> On Fri, 26 Apr 2002, Andrew Morton wrote:
> > Maneesh Soni wrote:
> > >..
> > > +static inline int walk_one(struct nameidata *nd)
> >
> > This function is hundreds and hundreds of bytes of code.  It has
> > three call sites.  Making it an inline is very inefficient!
>
> Unfortunately, this is a very special case.  This sucker is involved
> in mutual recursion and extra frame on stack will be nasty for, say it,
> sparc.  Normally I would agree that something of that kind should not be
> inlined, but...

Maybe add a comment? Or this question will emerge on lkml from time to time.
--
vda
