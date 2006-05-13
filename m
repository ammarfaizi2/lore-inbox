Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbWEMX2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWEMX2r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 19:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWEMX2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 19:28:47 -0400
Received: from cassarossa.samfundet.no ([129.241.93.19]:3557 "EHLO
	cassarossa.samfundet.no") by vger.kernel.org with ESMTP
	id S964802AbWEMX2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 19:28:46 -0400
Date: Sun, 14 May 2006 01:28:42 +0200
From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, dm-devel@redhat.com, neilb@suse.de
Subject: Re: [PATCH] Remove softlockup from invalidate_mapping_pages. (might be dm related)
Message-ID: <20060513232842.GA8591@uio.no>
References: <20060426135809.10a37ec3.akpm@osdl.org> <20060513134908.GA4480@uio.no> <20060513073344.4fcbc46b.akpm@osdl.org> <20060513144334.GA6013@uio.no> <20060513075147.423d18bd.akpm@osdl.org> <20060513150003.GA6096@uio.no> <20060513082409.4d173ccc.akpm@osdl.org> <20060513153231.GA6277@uio.no> <20060513084317.50356155.akpm@osdl.org> <20060513171414.GA7628@uio.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060513171414.GA7628@uio.no>
X-Operating-System: Linux 2.6.16.11 on a x86_64
X-Message-Flag: Outlook? --> http://www.mozilla.org/products/thunderbird/
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 13, 2006 at 07:14:14PM +0200, Steinar H. Gunderson wrote:
> I guess it's time for memtest86, just in case I botched the RAM while
> moving it...

Good news! :-) memtest86+ refused to boot, since I have too much memory (2GB)
and this somehow interferes with grub, but mprime (my other favourite tool
for this kind of testing) quite quickly bombed out. (This in itself usually
means bad RAM, bad motherboard or some interrupt handler messing up badly.)

I moved the RAM from DIMM slot 3+4 to 1+2, and suddenly things became a _lot_
better. I definitely can't say it's oops-free yet, since it's only been
running a couple of hours, but this certainly points towards that the larger
part of my issues were some odd sort of motherboard hiccup.

I take it this also frees the dm, md and NUMA code of most suspicion --
consider the issues fixed for now, and I'll be sure to bug you again if I
start to get oopses again. Sorry for wasting your time :-)

/* Steinar */
-- 
Homepage: http://www.sesse.net/
