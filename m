Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbTEBPNA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 11:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbTEBPM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 11:12:59 -0400
Received: from chaos.analogic.com ([204.178.40.224]:38289 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262914AbTEBPM6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 11:12:58 -0400
Date: Fri, 2 May 2003 11:27:30 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Kevin Corry <kevcorry@us.ibm.com>
cc: viro@parcelfarce.linux.theplanet.co.uk, Bodo Rzany <bodo@rzany.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: is there small mistake in lib/vsprintf.c of kernel 2.4.20 ?
In-Reply-To: <200305021003.33638.kevcorry@us.ibm.com>
Message-ID: <Pine.LNX.4.53.0305021116340.9129@chaos>
References: <20030502090835.GX10374@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.44.0305021131290.493-100000@joel.ro.ibrro.de>
 <20030502095018.GY10374@parcelfarce.linux.theplanet.co.uk>
 <200305021003.33638.kevcorry@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 May 2003, Kevin Corry wrote:

> On Friday 02 May 2003 04:50, viro@parcelfarce.linux.theplanet.co.uk wrote:
> > On Fri, May 02, 2003 at 11:42:36AM +0200, Bodo Rzany wrote:
> > > > IOW, %d _does_ mean base=10.  base=0 is %i.  That goes both for kernel
> > > > and userland implementations of scanf family (and for any
> > > > standard-compliant implementation, for that matter).

What!??????

The base, in the kernel code is the number that you divide by
to return the remainder for numerical conversions!  the base
is 8 or octal, 10 for decimal, 16 for hexadecimal, and up to
36 for some other strange unused thing (all 26 letters of the
alphabet).

If your conversion chances the base to 0, you divide by 0 (not
good) and don't get a remainder. Actually  procedure number()
protects against a base less than 2 or greater than 36 so you
just prevent conversion altogether.


> > >
> > > As I can see, 'base=10' is used for all conversions except for '%x' and
> > > '%o'. If '%i' or '%u' are given, base should be really set to 0, what is
> > > not the case (it is fixed to 10 instead!).
> >

No No No!


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

