Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287641AbRLaU3c>; Mon, 31 Dec 2001 15:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287639AbRLaU3W>; Mon, 31 Dec 2001 15:29:22 -0500
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:18840 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S287642AbRLaU3Q>; Mon, 31 Dec 2001 15:29:16 -0500
Date: Mon, 31 Dec 2001 20:31:22 +0000
From: Dave Jones <davej@suse.de>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Andrew Morton <akpm@zip.com.au>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Prefetching file_read_actor()
Message-ID: <20011231203122.A17288@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Manfred Spraul <manfred@colorfullife.com>,
	Andrew Morton <akpm@zip.com.au>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20011231033220.A1686@suse.de> <3C2FFB2F.D02095A2@zip.com.au> <3C3044D3.EBEF6657@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C3044D3.EBEF6657@colorfullife.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2001 at 11:58:27AM +0100, Manfred Spraul wrote:
 > > What happens if a prefetch spills over the end of the page and
 > > faults?
 
 > Doesn't hurt, prefetch instruction never cause page faults.
 > BUT: Prefetch doesn't preload the TLB. If the TLB entry for the kmap is
 > not in the TLB, all prefetch instructions are treated as nops.(on pIII).

 Wasn't this the reason for the voodoo workaround we have in
 the mmx version of fast_copy_page() ?

 Dave.

-- 
Dave Jones.                    http://www.codemonkey.org.uk
SuSE Labs.
