Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268359AbTBNJj7>; Fri, 14 Feb 2003 04:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268357AbTBNJi6>; Fri, 14 Feb 2003 04:38:58 -0500
Received: from kerberos.ncsl.nist.gov ([129.6.57.216]:4748 "EHLO
	kerberos.ncsl.nist.gov") by vger.kernel.org with ESMTP
	id <S268331AbTBNJiZ>; Fri, 14 Feb 2003 04:38:25 -0500
Date: Fri, 14 Feb 2003 04:48:18 -0500
From: Olivier Galibert <galibert@pobox.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] smctr.c changes in latest BK
Message-ID: <20030214044818.A5658@kerberos.ncsl.nist.gov>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0302132335540.28838-100000@gfrw1044.bocc.de> <Pine.LNX.4.44.0302140001160.28838-100000@gfrw1044.bocc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0302140001160.28838-100000@gfrw1044.bocc.de>; from jochen@scram.de on Fri, Feb 14, 2003 at 12:05:24AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2003 at 12:05:24AM +0100, Jochen Friedrich wrote:
> On Thu, 13 Feb 2003, Jochen Friedrich wrote:
> > Please revert this one as it is just wrong. As already mentioned here in
> > LKML (IIRC it was Alan), the semicolon is really intended here.
> >
> > The above loop just runs until a non-zero byte is found in the MAC
> > address or all 6 bytes have been checked. A value of i=6 will then
> > indicate an all-zero MAC address.
> 
> After taking a second look, i just recognized that both cases (MAC adress
> all-zero or not) are handled exactly the same (by duplicated code), so the
> whole stuff is unnecessary.
> 
> The whole function just reduces to a simple copy loop:

Doesn't that mean that the original function was buggy and it should
not have copied the mac address over if one was user-provided?

  OG.
