Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbVHHRKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbVHHRKP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 13:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbVHHRKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 13:10:15 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62989 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932103AbVHHRKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 13:10:14 -0400
Date: Mon, 8 Aug 2005 18:10:05 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Christoph Lameter <christoph@lameter.com>
Cc: Richard Purdie <rpurdie@rpsys.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       linux-arm@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm3
Message-ID: <20050808181004.B12788@flint.arm.linux.org.uk>
Mail-Followup-To: Christoph Lameter <christoph@lameter.com>,
	Richard Purdie <rpurdie@rpsys.net>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
	linux-arm@vger.kernel.org
References: <1122933133.7648.141.camel@localhost.localdomain> <Pine.LNX.4.62.0508011517300.8498@graphe.net> <1122937261.7648.151.camel@localhost.localdomain> <Pine.LNX.4.62.0508031716001.24733@graphe.net> <1123154825.8987.33.camel@localhost.localdomain> <Pine.LNX.4.62.0508040703300.3277@graphe.net> <1123166252.8987.50.camel@localhost.localdomain> <Pine.LNX.4.62.0508050817060.28659@graphe.net> <1123422275.7800.24.camel@localhost.localdomain> <Pine.LNX.4.62.0508080945100.19665@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.62.0508080945100.19665@graphe.net>; from christoph@lameter.com on Mon, Aug 08, 2005 at 09:48:22AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2005 at 09:48:22AM -0700, Christoph Lameter wrote:
> On Sun, 7 Aug 2005, Richard Purdie wrote:
> 
> > > > We know the the failure case can be identified by the
> > > > cmpxchg_fail_flag_update condition being met. Can you provide me with a
> > > > patch to dump useful debugging information when that occurs?
> > 
> > Ok, this results in an infinite loop of one message with no change to
> > the numbers:
> > 
> > cmpxchg fail mm=c3455ae0 vma=c355517c addr=4025f000 write=2048
> > ptep=c2f0597c pmd=c2b79008 entry=88000f7 new=8800077
> 
> Ok. So we cannot set the dirty bit.
> 
> Here is a patch that also prints the pte status immediately before 
> ptep_cmpxchg. I guess this will show that dirty bit is already set.
> 
> Does the ARM have some hardware capability to set dirty bits?

ARM doesn't have cmpxchg nor does it have hardware access nor dirty
bits.  They're simulated in software.

What's the problem you're trying to solve?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
