Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263491AbTAVVGn>; Wed, 22 Jan 2003 16:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263544AbTAVVGm>; Wed, 22 Jan 2003 16:06:42 -0500
Received: from holomorphy.com ([66.224.33.161]:9364 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S263491AbTAVVGl>;
	Wed, 22 Jan 2003 16:06:41 -0500
Date: Wed, 22 Jan 2003 13:15:48 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: remove EXT2_MAX_BLOCK_SIZE
Message-ID: <20030122211548.GS780@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20030122202851.GR780@holomorphy.com> <20030122141242.K1594@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030122141242.K1594@schatzie.adilger.int>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2003 at 02:12:42PM -0700, Andreas Dilger wrote:
> Actually, the correct fix is to check in ext2_read_super() whether the
> blocksize is larger than EXT2_MAX_BLOCK_SIZE like ext3 does, and maybe
> even fix up the code drift between that part of ext2_read_super() and
> ext3_read_super()...
> Both ext2 and ext3 will in theory support a blocksize up to PAGE_SIZE,
> but nobody with access to a > 4kB PAGE_SIZE system has bothered to test
> whether it works, so EXT[23]_MAX_BLOCK_SIZE has not been increased.
> Any e2fsprogs from the last year or so will support larger blocksizes,
> but it has never been tested AFAIK.

Block sizes > 4K should be trivially testable on IA64. ISTR bcrl having
patches to increase PAGE_CACHE_SIZE independently of PAGE_SIZE and
repair ext2's assumptions, so they should also be testable that way.


-- wli
