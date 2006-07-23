Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWGWEJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWGWEJX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 00:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWGWEJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 00:09:23 -0400
Received: from [216.208.38.107] ([216.208.38.107]:7050 "EHLO OTTLS.pngxnet.com")
	by vger.kernel.org with ESMTP id S1750716AbWGWEJX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 00:09:23 -0400
Subject: Re: remove cpu hotplug bustification in cpufreq.
From: Arjan van de Ven <arjan@linux.intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
       davej@redhat.com, Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607221813020.29649@g5.osdl.org>
References: <20060722194018.GA28924@redhat.com>
	 <Pine.LNX.4.64.0607221707400.29649@g5.osdl.org>
	 <20060722180602.ac0d36f5.akpm@osdl.org>
	 <Pine.LNX.4.64.0607221813020.29649@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 23 Jul 2006 06:09:14 +0200
Message-Id: <1153627754.7359.17.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-22 at 18:15 -0700, Linus Torvalds wrote:
> 
> On Sat, 22 Jul 2006, Andrew Morton wrote:
> > 
> > It was just wrong in conception.  We should not and probably cannot fix it.
> > Let's just delete it all, then implement version 2.
> 
> Well, I just got Ashok's trial patches which turns the thing into a rwsem 
> as I outlined earlier.

with rwsems being 100% fair... how is that going to make a difference?
Other than just making the deadlock harder to trigger because the writer
needs to come in just at the right time...
