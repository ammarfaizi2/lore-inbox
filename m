Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263468AbVCEAgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263468AbVCEAgj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263460AbVCEAMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:12:31 -0500
Received: from gate.crashing.org ([63.228.1.57]:12270 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263376AbVCDXao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 18:30:44 -0500
Subject: Re: [PATCH/RFC] I/O-check interface for driver's error handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, Linas Vepstas <linas@austin.ibm.com>,
       "Luck, Tony" <tony.luck@intel.com>
In-Reply-To: <20050304231807.GC2647@elf.ucw.cz>
References: <422428EC.3090905@jp.fujitsu.com>
	 <Pine.LNX.4.58.0503010844470.25732@ppc970.osdl.org>
	 <20050301165904.GN28741@parcelfarce.linux.theplanet.co.uk>
	 <200503010910.29460.jbarnes@engr.sgi.com>
	 <20050304135429.GC3485@openzaurus.ucw.cz>
	 <1109975846.5680.305.camel@gaston> <20050304225710.GB2647@elf.ucw.cz>
	 <1109977417.5611.318.camel@gaston>  <20050304231807.GC2647@elf.ucw.cz>
Content-Type: text/plain
Date: Sat, 05 Mar 2005 10:27:07 +1100
Message-Id: <1109978827.5680.324.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-03-05 at 00:18 +0100, Pavel Machek wrote:
> On So 05-03-05 10:03:37, Benjamin Herrenschmidt wrote:
> > On Fri, 2005-03-04 at 23:57 +0100, Pavel Machek wrote:
> > 
> > > What prevents driver from being run on another CPU, maybe just doing
> > > mdelay() between hardware accesses? 
> > 
> > Almost all drivers that I know have some sort of locking. Nothing nasty
> > about it. Besides, you can't expect everything to be as simple as
> > putting two bit of lego together, the problem isn't simple.
> 
> If error() is allowed to sleep, then yes, its probably easy enough. If
> it is not allowed to sleep, it will just postpone work to context that
> is allowed to sleep, and it will probably be okay, too.

Yes, it's my itend that the notification callback is to be called in a
task context where it can sleep.

> => there are some locking issues, but they are probably easy
> enough. Sorry for noise.
> 								Pavel
> 
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

