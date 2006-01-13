Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422757AbWAMR4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422757AbWAMR4q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 12:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422754AbWAMR4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 12:56:46 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:147 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1422756AbWAMR4o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 12:56:44 -0500
Date: Fri, 13 Jan 2006 18:56:12 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, jgarzik@pobox.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [git patches] 2.6.x net driver updates
In-Reply-To: <Pine.LNX.4.64.0601121444030.3535@g5.osdl.org>
Message-ID: <Pine.LNX.4.61.0601131844230.30994@scrub.home>
References: <20060112221322.GA25470@havoc.gtf.org> <Pine.LNX.4.64.0601121423120.3535@g5.osdl.org>
 <20060112143938.5cf7d6a5.akpm@osdl.org> <Pine.LNX.4.64.0601121444030.3535@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 12 Jan 2006, Linus Torvalds wrote:

> > Yes, I think that's much more Aunt-Nellie-friendly, but Roman considers it
> > abuse of the Kconfig system in ways which I never completely understood?
> 
> Hmm. If Roman dislikes it, he must dislike the fact that we already do 
> exactly this for a ton of different things. There's something like 2000+ 
> "select" statements in the kernel Kconfig tree, and just grepping for 
> "select.*CRYPTO" gets 52 hits..

The basic problem is that it overrides any other dependencies and it makes 
easy to screw them up.
The basic rule should be to use select only to include library 
functionality, which is mostly independent and has no other dependencies.
Selecting larger subsystem, which may require more configuration itself, 
should be avoided.

bye, Roman
