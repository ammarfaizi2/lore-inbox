Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263355AbVCEAgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263355AbVCEAgm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbVCEAJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:09:45 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1939 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261511AbVCDXS3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 18:18:29 -0500
Date: Sat, 5 Mar 2005 00:18:07 +0100
From: Pavel Machek <pavel@suse.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, Linas Vepstas <linas@austin.ibm.com>,
       "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH/RFC] I/O-check interface for driver's error handling
Message-ID: <20050304231807.GC2647@elf.ucw.cz>
References: <422428EC.3090905@jp.fujitsu.com> <Pine.LNX.4.58.0503010844470.25732@ppc970.osdl.org> <20050301165904.GN28741@parcelfarce.linux.theplanet.co.uk> <200503010910.29460.jbarnes@engr.sgi.com> <20050304135429.GC3485@openzaurus.ucw.cz> <1109975846.5680.305.camel@gaston> <20050304225710.GB2647@elf.ucw.cz> <1109977417.5611.318.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109977417.5611.318.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On So 05-03-05 10:03:37, Benjamin Herrenschmidt wrote:
> On Fri, 2005-03-04 at 23:57 +0100, Pavel Machek wrote:
> 
> > What prevents driver from being run on another CPU, maybe just doing
> > mdelay() between hardware accesses? 
> 
> Almost all drivers that I know have some sort of locking. Nothing nasty
> about it. Besides, you can't expect everything to be as simple as
> putting two bit of lego together, the problem isn't simple.

If error() is allowed to sleep, then yes, its probably easy enough. If
it is not allowed to sleep, it will just postpone work to context that
is allowed to sleep, and it will probably be okay, too.

=> there are some locking issues, but they are probably easy
enough. Sorry for noise.
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
