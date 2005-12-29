Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbVL2XDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbVL2XDO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 18:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbVL2XDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 18:03:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:11977 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751092AbVL2XDN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 18:03:13 -0500
Date: Thu, 29 Dec 2005 18:03:07 -0500
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: userspace breakage
Message-ID: <20051229230307.GB24452@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Greg KH <greg@kroah.com>
References: <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org> <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu> <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu> <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org> <20051229202852.GE12056@redhat.com> <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org> <20051229224103.GF12056@redhat.com> <Pine.LNX.4.64.0512291451440.3298@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512291451440.3298@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2005 at 02:56:16PM -0800, Linus Torvalds wrote:

 > That really isn't acceptable. Breaking user space - even things that are 
 > "close" to the kernel like udev scripts and alsa-lib, really is NOT a good 
 > idea.
 > 
 > If you cannot upgrade a kernel without ugrading some user package, that 
 > should be considered a real bug and a regression.

I'm glad you agree.  I've decided to try something different once 2.6.16
is out.  Every day, I'm going to push the -git snapshot of the day into
a testing branch for Fedora users. (Normally, only rawhide[1] users 
get to test kernel-de-jour, and this always has the latest userspace, so
we don't notice problems until a kernel point release and the stable
distro gets an update).

It'll come with disclaimers up the whazoo about it possibly crashing,
eating your cat etc, but I bet some loonies will be mad enough to
try it, and report when it crashes and burns. This should at least
get us knowing about *when* we break things sooner.

During 2.6.16rc, expect more screaming.

		Dave

[1] For non-Red Hat savvy, rawhide=='fedora development branch'

