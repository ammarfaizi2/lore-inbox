Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbUCKE6f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 23:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262637AbUCKE6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 23:58:35 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:20198 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S262256AbUCKE6d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 23:58:33 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Tom Rini <trini@kernel.crashing.org>, Andi Kleen <ak@muc.de>
Subject: Re: kgdb for mainline kernel: core-lite [patch 1/3]
Date: Thu, 11 Mar 2004 10:27:51 +0530
User-Agent: KMail/1.5
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       george@mvista.com, pavel@ucw.cz
References: <1xpyM-2Op-21@gated-at.bofh.it> <20040310123605.GA62228@colin2.muc.de> <20040310152750.GE5169@smtp.west.cox.net>
In-Reply-To: <20040310152750.GE5169@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403111027.52534.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 Mar 2004 8:57 pm, Tom Rini wrote:
> On Wed, Mar 10, 2004 at 01:36:05PM +0100, Andi Kleen wrote:
> > > Yes. But as things stand, gdb 6.0 doesn't show stack traces correctly
> > > with esp and eip got from switch_to and gas 2.14 can't handle i386
> > > dwarf2 CFI. Do we want to enforce getting a CVS version of gdb _and_
> > > gas to build kgdb? Certainly not.
> >
> > binutils 2.15 should be released soon anyways AFAIK. And for x86-64 this
> > all works just fine (as demonstrated by Jim's/George's stub), so please
> > get rid of it at least for x86-64. I really don't want user_schedule
> > there, because it's completely unnecessary.
>
> I think more importantly, it's probably going to be one of those ugly
> things that will make it so much harder to get it into Linus' tree.  So
> lets just say it'll require gdb 6.1 / binutils 2.15 for KGDB to work
> best.

If we are enforcing this we need to do it correctly: is there any way to check 
from source code whether binutils version is correct (even a gas check will 
suffice)

-Amit

