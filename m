Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262876AbUC2OV6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 09:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbUC2OV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 09:21:57 -0500
Received: from ns.suse.de ([195.135.220.2]:22670 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262876AbUC2OVz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 09:21:55 -0500
Subject: Re: Very poor performance with 2.6.4
From: Chris Mason <mason@suse.com>
To: Andreas Hartmann <andihartmann@freenet.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <4067BF2C.8050801@p3EE060D4.dip0.t-ipconnect.de>
References: <40672F39.5040702@p3EE062D5.dip0.t-ipconnect.de>
	 <20040328200710.66a4ae1a.akpm@osdl.org>
	 <4067BF2C.8050801@p3EE060D4.dip0.t-ipconnect.de>
Content-Type: text/plain
Message-Id: <1080570227.20685.93.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 29 Mar 2004 09:23:48 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-03-29 at 01:16, Andreas Hartmann wrote:
> Andrew Morton wrote:
> > Andreas Hartmann <andihartmann@freenet.de> wrote:
> >>
> >> I tested kernel 2.6.4. While compiling kdelibs and kdebase, I felt, that
> >>  kernel 2.6 seems to be slower than 2.4.25.
> >> 
> >>  So I did some tests to compare the performance directly. Therefore I
> >>  rebooted for everey test in init 2 (no X).
> >> 
> >>  I locally compiled 2.6.5rc2 3 times under 2.6.4 and under 2.4.25 on a
> >>  reiserfs LVM partition, which resides onto a IDE HD (using DMA) and got
> >>  the following result:
> >> 
> >>  In the middle, compiling under kernel 2.6.4 tooks 9.3% more real time than
> >>  under 2.4.25.
> >>  The user-processortime is about the same, but the system-processortime is
> >>  under 2.6.4 32.9% higher than under 2.4.25.
> > 
> > Try mounting your reiserfs filesystems with the `-o nolargeio=1' option.
> 
> This didn't help.
> 
> > 
> > If that doesn't help, please run a comparative kernel profile.  See
> > Documentation/basic_profiling.txt.
> 
> I'll do this next.

You might also want to try 2.6.5-rc2 which has a set of reiserfs fixes
from 2.4.x.  I'm hoping those will clean things up for you.

2.6.5-rc2-mm3 and higher have a number of other reiserfs performance
fixes, but most of those were not in 2.4.  Trying them out will
complicate the picture (although I'm still interested in numbers from
-mm).

-chris


