Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264220AbTICTQz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 15:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264116AbTICTOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 15:14:46 -0400
Received: from mail.dubki.ru ([80.240.116.2]:37133 "EHLO mail.dubki.ru")
	by vger.kernel.org with ESMTP id S264220AbTICSym (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 14:54:42 -0400
From: "Nikita V. Youshchenko" <yoush@cs.msu.su>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: Strange situation while writing CDR from iso file on tmpfs
Date: Wed, 3 Sep 2003 22:54:50 +0400
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0309031745110.2222-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0309031745110.2222-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309032254.50468@sercond.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> tmpfs is fine while everything is in memory, and even when a little
> overflowed to swap; but with so much on swap it's at the mercy of the
> vagaries of the LRU lists, and swap allocation might work out far
> from optimal for it.  tmpfs use of swap is not something we've ever
> tried to optimize for.

Hmm...
Until today I thought that it is a good administration style to create a 
several gigabyte swap partition (which is normally almost unused, but 
just for the case that some program needs much virtual memory), and use 
tmpfs for /tmp.
I thought that it is good for two reasons - disk space is not wasted for 
/tmp (and /tmp still has several gigabytes of space), and short-living 
temporary files such as gcc intermediate files normally reside in memory, 
which is more effective than using a filesystem on a disk.

If I understand you correctly, the above is not true at least for a 
desktop system with 256M of RAM?

And what about LTSP server with 2 gigabytes of RAM (and 6 gigabytes of 
swap) that normally runs 10-15 KDE sessions with mozilla's and 
openoffice's?

> Perhaps something exceptionally stupid and avoidable occurs, I'll keep
> your mail as reminder to investigate some day.

Thank you.

