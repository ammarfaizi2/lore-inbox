Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbUB0Bnl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 20:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbUB0Bnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 20:43:40 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:17566 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261728AbUB0BnJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 20:43:09 -0500
Date: Thu, 26 Feb 2004 17:41:30 -0800 (PST)
From: Sridhar Samudrala <sri@us.ibm.com>
X-X-Sender: sridhar@localhost.localdomain
To: Sridhar Samudrala <sri@us.ibm.com>
cc: Adrian Bunk <bunk@fs.tum.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.26-pre1: SCTP compile error
In-Reply-To: <Pine.LNX.4.58.0402261533500.19577@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0402261735490.31520@localhost.localdomain>
References: <Pine.LNX.4.58L.0402251605360.5003@logos.cnet>
 <20040226212759.GV5499@fs.tum.de> <Pine.LNX.4.58.0402261533500.19577@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Feb 2004, Sridhar Samudrala wrote:

> On Thu, 26 Feb 2004, Adrian Bunk wrote:
>
> > On Wed, Feb 25, 2004 at 04:09:20PM -0300, Marcelo Tosatti wrote:
> > >...
> > > It contains a big SCTP merge (to match 2.6 API), networking updates,
> > >...
> >
> > I got the compile error forwarded below using gcc 2.95.3 .
> >
> > cu
> > Adrian
> >
> >
> >
> > ...
> > gcc-2.95 -D__KERNEL__ -I/home/bunk/linux/kernel-2.4/linux-2.4.26-pre1-full/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4   -nostdinc -iwithprefix include -DKBUILD_BASENAME=ipv6  -c -o ipv6.o ipv6.c
> > In file included from ipv6.c:77:
> > /home/bunk/linux/kernel-2.4/linux-2.4.26-pre1-full/include/net/sctp/sctp.h:119: warning: `MSECS_TO_JIFFIES' redefined
> > /home/bunk/linux/kernel-2.4/linux-2.4.26-pre1-full/include/net/irda/irda.h:89: warning: this is the location of the previous definition
>
> I missed this warning as i don't have irda enabled in my config.
> A simple fix would be to rename the macro in sctp.h to
> SCTP_MSECS_TO_JIFFIES.
>
> > ipv6.c: In function `sctp_v6_xmit':
> > ipv6.c:189: request for member `in6_u' in something not a structure or union
> > ipv6.c:189: request for member `in6_u' in something not a structure or union
>
> I am not seeing these errors with either gcc3.2.2 or gcc2.96. But, looking at the
> code, this definitely seems to be a problem. Not sure why the newer versions of
> gcc didn't catch them.

It is my mistake. I don't have CONFIG_SCTP_DBG_MSG enabled and so these lines are
compiled out and hence i am not seeing these errors.

Thanks
Sridhar
