Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbUAOT40 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 14:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbUAOT40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 14:56:26 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:58759
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262308AbUAOTzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 14:55:38 -0500
Date: Thu, 15 Jan 2004 16:02:58 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andi Kleen <ak@colin2.muc.de>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org, jh@suse.cz
Subject: Re: [PATCH] Add CONFIG for -mregparm=3
Message-ID: <20040115150258.GA464@dualathlon.random>
References: <20040114090603.GA1935@averell> <20040114012928.1e90af3b.akpm@osdl.org> <20040114093556.GB19652@colin2.muc.de> <20040114192505.GJ23383@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040114192505.GJ23383@fs.tum.de>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 08:25:06PM +0100, Adrian Bunk wrote:
> On Wed, Jan 14, 2004 at 10:35:56AM +0100, Andi Kleen wrote:
> >...
> > I think the popular modules like nvidia or ATI could be fixed 
> > relatively easily.  They usually consist of a glue layer with source and a 
> > binary blob that is only called from the glue layer. Basically all you 
> > have to do is the mark the prototypes for the binary blob in the glue layer
> > as "asmlinkage". In addition this can be done without any ifdefs
> > because asmlinkage does the right thing on a non regparm kernel.
> > 
> > Of course true binary only modules without glue layer would be more
> > difficult, but for those the vendors just have to recompile. Conceivable
> > it would be possible to write a glue layer even for them.
> >...
> 
> Did I miss Linus announcing a stable ABI between kernel versions?
> 
> If some binary module vendor tries to support more than one kernel
> version it's his problem - this is nothing that is officially supported
> by the Linux kernel.

agreed.

this is the sort of stuff that shouldn't be a config option, it
exercises new paths in gcc as well, _all_ the userbase has to use it, or
it's not worth the risk/pain IMHO.
