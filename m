Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263518AbTIWT3Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 15:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263517AbTIWT3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 15:29:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23463 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263499AbTIWT2J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 15:28:09 -0400
Date: Tue, 23 Sep 2003 20:28:04 +0100
From: Matthew Wilcox <willy@debian.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Andreas Schwab <schwab@suse.de>, bcrl@kvack.org, tony.luck@intel.com,
       davidm@hpl.hp.com, davidm@napali.hpl.hp.com, peter@chubb.wattle.id.au,
       ak@suse.de, iod00d@hp.com, peterc@gelato.unsw.edu.au,
       linux-ns83820@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-ID: <20030923192804.GG13172@parcelfarce.linux.theplanet.co.uk>
References: <DD755978BA8283409FB0087C39132BD101B01194@fmsmsx404.fm.intel.com> <20030923142925.A16490@kvack.org> <jehe3372th.fsf@sykes.suse.de> <20030923115200.1f5b44df.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030923115200.1f5b44df.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 11:52:00AM -0700, David S. Miller wrote:
> On Tue, 23 Sep 2003 20:54:50 +0200
> Andreas Schwab <schwab@suse.de> wrote:
> 
> > Unaligned access are a BUG.
> 
> Wrong, they've been allowed in the kernel networking from day
> one and there is nothing that can be done to avoid the cases
> for which they occur.

That's not true; they could be avoided by using get_unaligned() and
put_unaligned().  You just don't want to because they'd make sparc suck.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
