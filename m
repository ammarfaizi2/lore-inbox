Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262378AbVCHVcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbVCHVcM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 16:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262379AbVCHVcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 16:32:12 -0500
Received: from mailfe09.swipnet.se ([212.247.155.1]:44456 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262378AbVCHVcB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 16:32:01 -0500
X-T2-Posting-ID: icQHdNe7aEavrnKIz+aKnQ==
Subject: Re: 2.6.11-mm1
From: Alexander Nyberg <alexn@dsv.su.se>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1109976924.9696.17.camel@boxen>
References: <20050304033215.1ffa8fec.akpm@osdl.org>
	 <1109974593.9696.11.camel@boxen>  <20050304143947.4e1e1bc2.akpm@osdl.org>
	 <1109976924.9696.17.camel@boxen>
Content-Type: text/plain
Date: Tue, 08 Mar 2005 22:31:52 +0100
Message-Id: <1110317512.18851.4.camel@boxen>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm1/
> > > > 
> > > > 
> > > > - Added the new bk-audit tree.  Contains updates to the kernel's audit
> > > >   feature.  Maintained by David Woodhouse.
> > > > 
> > > > - The Dell keyboard problems should be fixed.  Testing needed.
> > > > 
> > > > - Dmitry's bk-dtor-input tree is no longer active and has been dropped.
> > > 
> > > Just booted up a box and tried to log onto ssh which didn't worked so I
> > > looked at kernel log and behold, 128MB box with no swap, had just
> > > booted. Couldn't get any access after this.
> > > A few kernel debugging options were chosen notably CONFIG_DEBUG_SLAB &
> > > CONFIG_DEBUG_PAGEALLOC
> > 
> > So you're saying that the box has run out of memory?
> > 
> > Please send me the .config then disable CONFIG_DEBUG_PAGEALLOC and retest,
> > thanks.
> > 
> 
> Sorry for not making it clear, it was a one-time thing unfortunately.
> 
> I'll be hitting the reset button on the box to see if I can trigger it
> again somehow.

Just fyi, it appears to be a leak in dm-crypt that caused this, i've
forwarded it to dm-devel...

