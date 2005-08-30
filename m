Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbVH3Oua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbVH3Oua (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 10:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbVH3Ou3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 10:50:29 -0400
Received: from ns2.suse.de ([195.135.220.15]:24271 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932164AbVH3Ou2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 10:50:28 -0400
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] i386, x86_64 Initial PAT implementation
Date: Tue, 30 Aug 2005 16:50:22 +0200
User-Agent: KMail/1.8
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <m1psrwmg10.fsf@ebiederm.dsl.xmission.com> <1125413136.8276.14.camel@localhost.localdomain>
In-Reply-To: <1125413136.8276.14.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508301650.23149.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 August 2005 16:45, Alan Cox wrote:
> On Llu, 2005-08-29 at 18:20 -0600, Eric W. Biederman wrote:
> > ways.  Currently this code only allows for an additional flavor
> > of uncached access to physical memory addresses which should be hard
> > to abuse, and should raise no additional aliasing problems.  No
> > attempt has been made to fix theoretical aliasing problems.
>
> Even an uncached/cached alias causes random memory corruption or an MCE
> on x86 systems. In fact it can occur even for an alias not in theory
> touched by the CPU if it happens to prefetch into or speculate the
> address.
>
> Also be sure to read the PII Xeon errata - early PAT has a bug or two.


We can always force cpu_has_pat == 0 on these machines.
I don't think it is worth it to add any more complicated workarounds 
for old broken systems.

-Andi
