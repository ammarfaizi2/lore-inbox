Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbVH3Pcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbVH3Pcv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 11:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbVH3Pcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 11:32:51 -0400
Received: from aun.it.uu.se ([130.238.12.36]:11653 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S932176AbVH3Pcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 11:32:51 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17172.31726.480750.90360@alkaid.it.uu.se>
Date: Tue, 30 Aug 2005 17:31:58 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Andi Kleen <ak@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386, x86_64 Initial PAT implementation
In-Reply-To: <200508301650.23149.ak@suse.de>
References: <m1psrwmg10.fsf@ebiederm.dsl.xmission.com>
	<1125413136.8276.14.camel@localhost.localdomain>
	<200508301650.23149.ak@suse.de>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:
 > On Tuesday 30 August 2005 16:45, Alan Cox wrote:
 > > On Llu, 2005-08-29 at 18:20 -0600, Eric W. Biederman wrote:
 > > > ways.  Currently this code only allows for an additional flavor
 > > > of uncached access to physical memory addresses which should be hard
 > > > to abuse, and should raise no additional aliasing problems.  No
 > > > attempt has been made to fix theoretical aliasing problems.
 > >
 > > Even an uncached/cached alias causes random memory corruption or an MCE
 > > on x86 systems. In fact it can occur even for an alias not in theory
 > > touched by the CPU if it happens to prefetch into or speculate the
 > > address.
 > >
 > > Also be sure to read the PII Xeon errata - early PAT has a bug or two.
 > 
 > 
 > We can always force cpu_has_pat == 0 on these machines.
 > I don't think it is worth it to add any more complicated workarounds 
 > for old broken systems.

I don't have the spec updates in front of me, but I believe the PAT
bug existed well into the P4 line. The workaround is simply to make
the high 4 PAT entries identical to the low 4 entries. (But I confess
to not having a clue as to whether it's still useful then or not.)
