Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262855AbTJPK6C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 06:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262859AbTJPK6C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 06:58:02 -0400
Received: from smtprelay02.ispgateway.de ([62.67.200.157]:15811 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S262855AbTJPK6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 06:58:00 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
Reply-To: Ingo Oeser <ioe-lkml@rameria.de>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2.6] constant_test_bit doesn't like my gcc
Date: Thu, 16 Oct 2003 12:55:36 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.53.0310152244330.2328@montezuma.fsmlabs.com> <20031015212134.41a427d3.akpm@osdl.org> <Pine.LNX.4.53.0310160020060.2328@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.53.0310160020060.2328@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310161255.36380.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 October 2003 06:22, Zwane Mwaikambo wrote:
> On Wed, 15 Oct 2003, Andrew Morton wrote:
> > >   static __inline__ int constant_test_bit(int nr, const volatile
> > > unsigned long * addr) {
> > >  -	return ((1UL << (nr & 31)) & (((const volatile unsigned int *)
> > > addr)[nr >> 5])) != 0; +	return ((1UL << (nr & 31)) & (addr[nr >> 5]))
> > > != 0;
> > >   }
> >
> > Looks fine.  Does your compiler get this right?
>
> Yep, thanks.

Sorry, but I still don't get, what a "const volatile" is supposed to mean.

I would be thankful for an explanation (s. Reply-To).

Regards

Ingo Oeser


