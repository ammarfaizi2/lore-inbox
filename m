Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286073AbRLHXkz>; Sat, 8 Dec 2001 18:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286072AbRLHXkq>; Sat, 8 Dec 2001 18:40:46 -0500
Received: from holomorphy.com ([216.36.33.161]:44672 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S286071AbRLHXk2>;
	Sat, 8 Dec 2001 18:40:28 -0500
Date: Sat, 8 Dec 2001 15:40:21 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: [CFT] tree-based bootmem
Message-ID: <20011208154021.B939@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've waited a week or two for bug reports to roll in from early testers
(including myself), and no reports have come in.

So now I humbly request the assistance of a larger userbase in testing
the bootmem patch.

The bootmem subsystem is used for tracking and reserving usable physical
memory during early boot. A patch such as this, which tracks extents
explicitly, was requested by several people. The patch is also intended
to improve discontiguous memory support in that subsystem.

The only user-visible effect of the patch should be to save small
amounts of memory by virtue of somewhat more accurate tracking of the
boundaries of allocated regions, on the order of 4-12KB on i386.

The patch has been tested successfully on i386, IA64, mipsel, Super-H,
ppc64, sparc64, and sparc32, when applied against 2.4.15.

The patch (against various kernel versions) is available from

	ftp://ftp.kernel.org/pub/linux/kernel/people/wli/bootmem/

Those using the 2.4.15 patch will need to apply overflow-2.4.15 in
addition to bootmem-2.4.15


Thanks,
Bill
