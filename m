Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbUCAU4L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 15:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbUCAU4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 15:56:11 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:11435 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S261432AbUCAU4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 15:56:09 -0500
Date: Mon, 1 Mar 2004 20:54:26 +0000
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, yi.zhu@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [start_kernel] Suggest to move parse_args() before trap_init()
Message-ID: <20040301205426.GA5862@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	Andrew Morton <akpm@osdl.org>, yi.zhu@intel.com,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0403011721220.2367-100000@mazda.sh.intel.com> <20040301025637.338f41cf.akpm@osdl.org> <p73vfloz45t.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73vfloz45t.fsf@verdi.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2004 at 09:46:38PM +0100, Andi Kleen wrote:

 > > I think the only problem with this is if we get a fault during
 > > parse_args(), the kernel flies off into outer space.  So you lose some
 > > debuggability when using an early console.
 > > 
 > > But 2.4 does trap_init() after parse_args() and nobody has complained, as
 > > did 2.6 until recently.  So the change is probably OK.
 > 
 > The standard way to fix this is to add an explicit check for lapic
 > to the early argument parsing in setup.c (but keep the __setup so that
 > no unknown argument is reported).

This just got me thinking of a sort-of related problem.
Some laptops hang when local apic is enabled, and we couldn't
blacklist them in 2.4 due to us not doing the dmi scan early enough.

Did that get fixed in 2.6 ?

		Dave
