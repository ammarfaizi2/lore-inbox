Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288845AbSAFNMR>; Sun, 6 Jan 2002 08:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288787AbSAFNMI>; Sun, 6 Jan 2002 08:12:08 -0500
Received: from holomorphy.com ([216.36.33.161]:25801 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S288845AbSAFNLy>;
	Sun, 6 Jan 2002 08:11:54 -0500
Date: Sun, 6 Jan 2002 05:11:34 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove 8 bytes from struct page on 64bit archs
Message-ID: <20020106051134.E10391@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020106123913.GA5407@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20020106123913.GA5407@krispykreme>; from anton@samba.org on Sun, Jan 06, 2002 at 11:39:14PM +1100
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 06, 2002 at 11:39:14PM +1100, Anton Blanchard wrote:
> It seems shortening struct page is all the rage at the moment and I
> didnt want to be left out. On some 64bit architectures (sparc64 and
> ppc64 for example) all memory is allocated in the DMA zone. Therefore
> there is no reason to waste 8 bytes per page when every page points to
> the same zone!

Very true. I devised something to address this that appears to work on
multiple architectures already by folding ->zone into ->flags, which
could be useful. (Dave Jones recommended I just let arch maintainers
for things other than i386 mess with page_address() for other arches.)
OTOH, I'm more interested in getting it trimmed down than getting credit.


Cheers,
Bill

P.S.:

My i386 version, which makes ->virtual conditional on CONFIG_HIGHMEM as
well, is at:

ftp://ftp.kernel.org/pub/linux/kernel/people/wli/vm/struct_page/struct_page-2.4.17-rc2
