Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262679AbUKMNGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262679AbUKMNGN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 08:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262688AbUKMNGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 08:06:13 -0500
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224]:16053 "EHLO
	honk1.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id S262679AbUKMNGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 08:06:12 -0500
Date: Sat, 13 Nov 2004 14:02:57 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: Fix IO access in rivafb
Message-ID: <20041113130257.GA4696@bogon.ms20.nix>
References: <200411080521.iA85LbG6025914@hera.kernel.org> <1100309972.20511.103.camel@gaston> <20041113112234.GA5523@bogon.ms20.nix> <200411132000.31465.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411132000.31465.adaplas@hotpop.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 13, 2004 at 08:00:30PM +0800, Antonino A. Daplas wrote:
> On Saturday 13 November 2004 19:22, Guido Guenther wrote:
> > On Sat, Nov 13, 2004 at 12:39:32PM +1100, Benjamin Herrenschmidt wrote:
> > > On Fri, 2004-11-12 at 20:18 +0100, Guido Guenther wrote:
> > In 2.6.10-rc1-mm5 {in,out}_8 and read/writeb are exactly identical, only
> > __raw_{read,write}b is different. So you mean __raw_{read,write}b in the
> > above? (no nitpicking, just want to be sure I understand this
> > correctly).
> 
> Why not use in_be* and out_be* for __raw_read and raw_write?  If I
> understand correctly, they also have barriers.  Or would that hurt
> performance?
I think it would. XFree86 comes along without these barriers nicely (and
this this driver was written with documentation ;), so rivafb should be
o.k. too.
 -- Guido
