Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRABWeb>; Tue, 2 Jan 2001 17:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130879AbRABWeW>; Tue, 2 Jan 2001 17:34:22 -0500
Received: from raven.toyota.com ([63.87.74.200]:42509 "EHLO raven.toyota.com")
	by vger.kernel.org with ESMTP id <S129267AbRABWeK>;
	Tue, 2 Jan 2001 17:34:10 -0500
Message-ID: <3A52503E.13F20539@toyota.com>
Date: Tue, 02 Jan 2001 14:03:42 -0800
From: J Sloan <jjs@toyota.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-prerelease i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: LVM 0_9-1 woes on 2.4.0-prerelease+diffs
In-Reply-To: <3A52357C.FCB7B187@toyota.com> <20010102225844.E7563@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

> On Tue, Jan 02, 2001 at 12:09:32PM -0800, J Sloan wrote:
> > # vgscan
> > vgscan: error while loading shared libraries: vgscan: undefined symbol:
> > lvm_remove_recursive
>
> This looks like an userspace compilation/installation problem of the new lvm
> tools. Make sure you removed the old (0.8*) shared librarians. You can check
> which librarains you're using with:
>
>         ldd `which vgscan`

Ah, that was it! the old libs were in /lib, the
new libs are in /usr/lib, so I missed it.

Thanks, all is running smoothly again!

jjs


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
