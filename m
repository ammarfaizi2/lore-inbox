Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291414AbSAaXY5>; Thu, 31 Jan 2002 18:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291415AbSAaXYr>; Thu, 31 Jan 2002 18:24:47 -0500
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:32912 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S291414AbSAaXYf>; Thu, 31 Jan 2002 18:24:35 -0500
Date: Thu, 31 Jan 2002 23:27:43 +0000
From: Dave Jones <davej@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] remove sched.h dependancies from fs/
Message-ID: <20020131232743.A3830@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alexander Viro <viro@math.psu.edu>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's a large (90kb uncompressed) patch at ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/misc/sched-cleanup-2.diff.gz
which removes the inclusion of sched.h from a majority of fs/
It achieves this by moving CURRENT_TIME to time.h, and including that instead.
(time.h pulls in a thousand times less files than sched.h)

The only remaining users of sched.h in fs/ with this patch applied are
various users of fields from current->, and those who want jiffies.

(Linus, I know you prefer these things sent directly, if this sounds good,
 and Al likes it, I'll push it to you inline).

Dave.

-- 
Dave Jones.                    http://www.codemonkey.org.uk
SuSE Labs.
