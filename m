Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbUCKFKB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 00:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262637AbUCKFKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 00:10:01 -0500
Received: from fw.osdl.org ([65.172.181.6]:41123 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261460AbUCKFJ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 00:09:59 -0500
Date: Wed, 10 Mar 2004 21:05:10 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: trini@kernel.crashing.org, ak@muc.de, akpm@osdl.org,
       linux-kernel@vger.kernel.org, george@mvista.com, pavel@ucw.cz
Subject: Re: kgdb for mainline kernel: core-lite [patch 1/3]
Message-Id: <20040310210510.34b50793.rddunlap@osdl.org>
In-Reply-To: <200403111027.52534.amitkale@emsyssoft.com>
References: <1xpyM-2Op-21@gated-at.bofh.it>
	<20040310123605.GA62228@colin2.muc.de>
	<20040310152750.GE5169@smtp.west.cox.net>
	<200403111027.52534.amitkale@emsyssoft.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2004 10:27:51 +0530 "Amit S. Kale" <amitkale@emsyssoft.com> wrote:

| On Wednesday 10 Mar 2004 8:57 pm, Tom Rini wrote:
| > On Wed, Mar 10, 2004 at 01:36:05PM +0100, Andi Kleen wrote:
| > > > Yes. But as things stand, gdb 6.0 doesn't show stack traces correctly
| > > > with esp and eip got from switch_to and gas 2.14 can't handle i386
| > > > dwarf2 CFI. Do we want to enforce getting a CVS version of gdb _and_
| > > > gas to build kgdb? Certainly not.
| > >
| > > binutils 2.15 should be released soon anyways AFAIK. And for x86-64 this
| > > all works just fine (as demonstrated by Jim's/George's stub), so please
| > > get rid of it at least for x86-64. I really don't want user_schedule
| > > there, because it's completely unnecessary.
| >
| > I think more importantly, it's probably going to be one of those ugly
| > things that will make it so much harder to get it into Linus' tree.  So
| > lets just say it'll require gdb 6.1 / binutils 2.15 for KGDB to work
| > best.
| 
| If we are enforcing this we need to do it correctly: is there any way to check 
| from source code whether binutils version is correct (even a gas check will 
| suffice)

Documentation/Changes says to use "ld -v" for binutils version.

--
~Randy
