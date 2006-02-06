Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbWBFLrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWBFLrR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 06:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWBFLrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 06:47:17 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:11895 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751051AbWBFLrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 06:47:14 -0500
Date: Mon, 6 Feb 2006 20:47:02 +0900
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>, dev-etrax@axis.com,
       David Howells <dhowells@redhat.com>,
       Yoshinori Sato <ysato@users.sourceforge.jp>,
       Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
       Hirokazu Takata <takata@linux-m32r.org>, linux-m68k@vger.kernel.org,
       linux-mips@linux-mips.org, parisc-linux@parisc-linux.org,
       linuxsh-dev@lists.sourceforge.net,
       linuxsh-shmedia-dev@lists.sourceforge.net, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, Miles Bader <uclinux-v850@lsi.nec.co.jp>,
       Andi Kleen <ak@suse.de>, Chris Zankel <chris@zankel.net>
Subject: Re: [patch 15/44] generic ext2_{set,clear,test,find_first_zero,find_next_zero}_bit()
Message-ID: <20060206114702.GA11836@miraclelinux.com>
References: <20060201090224.536581000@localhost.localdomain> <20060201090326.139510000@localhost.localdomain> <Pine.LNX.4.61.0602011214270.12293@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602011214270.12293@scrub.home>
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2006 at 12:27:38PM +0100, Roman Zippel wrote:
> > +static __inline__ int generic_test_le_bit(unsigned long nr,
> > +				  __const__ unsigned long *addr)
> > +{
> > +	__const__ unsigned char	*tmp = (__const__ unsigned char *) addr;
> > +	return (tmp[nr >> 3] >> (nr & 7)) & 1;
> > +}
> 
> The underscores are not needed.
> 

Thanks, I converted to 'inline' and 'const'.

