Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131748AbQLLBry>; Mon, 11 Dec 2000 20:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131719AbQLLBre>; Mon, 11 Dec 2000 20:47:34 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:63242 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S131714AbQLLBrb>;
	Mon, 11 Dec 2000 20:47:31 -0500
Date: Mon, 11 Dec 2000 18:15:17 -0700
From: Cort Dougan <cort@fsmlabs.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: PATCH: linux-2.4.0-test12pre8/include/linux/module.h breaks sysklogd compilation
Message-ID: <20001211181517.N4528@hq.fsmlabs.com>
In-Reply-To: <20001211145901.A8047@baldur.yggdrasil.com> <3241.976583143@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <3241.976583143@kao2.melbourne.sgi.com>; from Keith Owens on Tue, Dec 12, 2000 at 12:05:43PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

} User space applications _must_ not include kernel headers.  Even
} modutils does not include linux/module.h, it has its own portable
} (kernels 2.0 - 2.4) version.

There are cases where a user-program _must_ include kernel headers.  Some
glibc versions have incorrect values for MCL_* and asm/mman.h has correct
versions.  If you want your mlock call to do anything, you need the kernel
header.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
