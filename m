Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129706AbRCHVJt>; Thu, 8 Mar 2001 16:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129719AbRCHVJj>; Thu, 8 Mar 2001 16:09:39 -0500
Received: from pizda.ninka.net ([216.101.162.242]:18048 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129706AbRCHVJ2>;
	Thu, 8 Mar 2001 16:09:28 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15015.62685.775963.665349@pizda.ninka.net>
Date: Thu, 8 Mar 2001 13:08:45 -0800 (PST)
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: flush_page_to_ram() question in kernel/ptrace.c
In-Reply-To: <3AA7E4E8.5EACF817@colorfullife.com>
In-Reply-To: <3AA7E4E8.5EACF817@colorfullife.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Manfred Spraul writes:
 > >                 memcpy(buf, maddr + (addr & ~PAGE_MASK), len);
 > >                 flush_page_to_ram(page);
 >                   ^^^^^^^^^^^^^^^^^^^^^^
 > Is this flush required?
 > 
 > The memcpy read from the mapping, it didn't write.

You have to kick it out of the cache so that future reads on the
kernel side don't get stale data with caching setups that allow
illegal aliases to form.

Later,
David S. Miller
davem@redhat.com







