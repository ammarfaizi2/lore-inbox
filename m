Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262244AbTC1Hbg>; Fri, 28 Mar 2003 02:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262258AbTC1Hbg>; Fri, 28 Mar 2003 02:31:36 -0500
Received: from rth.ninka.net ([216.101.162.244]:25024 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S262244AbTC1Hbf>;
	Fri, 28 Mar 2003 02:31:35 -0500
Subject: Re: BLKGETSIZE64 is broken (0x80041272)
From: "David S. Miller" <davem@redhat.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030327214214.B19517@devserv.devel.redhat.com>
References: <20030327214214.B19517@devserv.devel.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048837368.22744.0.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 27 Mar 2003 23:42:49 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-27 at 18:42, Pete Zaitcev wrote:
> I was adding ioctl translations and found that BLKGETSIZE64
> equals 0x80041272, with wrong size. Apparently, a whole bunch
> of ioctls takes sizeof(sizeof(foo)), which evaluates to 4
> in 32 bit userland, regardless of the size of foo.
> Are we going to do anything about it?

Anton and I noticed this a few months ago, we just handle it
the way it needs to be in the ioctl32 translation layers of
ppc64 and sparc64.  I believe we even notified people such
as Andi Kleen at the time this was discovered by Anton.

-- 
David S. Miller <davem@redhat.com>
