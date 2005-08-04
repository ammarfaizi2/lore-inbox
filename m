Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262704AbVHDTv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262704AbVHDTv7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 15:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbVHDTv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 15:51:58 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:26557 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262704AbVHDTvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 15:51:50 -0400
Subject: Re: [openib-general] Re: [RFC] Move InfiniBand .h files
From: Arjan van de Ven <arjan@infradead.org>
To: Grant Grundler <iod00d@hp.com>
Cc: Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <20050804182652.GF20422@esmail.cup.hp.com>
References: <52iryla9r5.fsf@cisco.com>
	 <1123178038.3318.40.camel@laptopd505.fenrus.org>
	 <20050804182652.GF20422@esmail.cup.hp.com>
Content-Type: text/plain
Date: Thu, 04 Aug 2005 21:51:10 +0200
Message-Id: <1123185070.3318.49.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-04 at 11:26 -0700, Grant Grundler wrote:
> On Thu, Aug 04, 2005 at 07:53:58PM +0200, Arjan van de Ven wrote:
> > On Thu, 2005-08-04 at 10:32 -0700, Roland Dreier wrote:
> > > I would like to get people's reactions to moving the InfiniBand .h
> > > files from their current location in drivers/infiniband/include/ to
> > > include/linux/rdma/.  If we agree that this is a good idea then I'll
> > > push this change as soon as 2.6.14 starts.
> > 
> > please only put userspace clean headers here; the rest is more or less
> > private headers for your subsystem. 
> 
> Sorry...this smells like a rathole...but does this mean
> linus agrees the kernel subsystems should export headers suitable for
> both user space and kernel driver modules?
> 
> Historical, I thought glibc and other user space libs were expected to
> maintain their own set of header files. Maybe I'm just confused...

there is a definite requirement for the kernel to expose SOME things to
userspace. Well for SOMETHING to expose them. Right now most distros
ship a hacked up version of the kernel headers (eg removed of all the
kernel specific stuff and all the gpl inline code etc). A good part of
making such an external project possible is to make a clean separation
between userspace shared stuff and pure kernel internals.


