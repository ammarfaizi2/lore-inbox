Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264341AbTICTTM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 15:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264127AbTICTOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 15:14:34 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:27063 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id S264308AbTICTMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 15:12:42 -0400
Date: Wed, 3 Sep 2003 20:14:16 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Nikita V. Youshchenko" <yoush@cs.msu.su>
cc: linux-kernel@vger.kernel.org
Subject: Re: Strange situation while writing CDR from iso file on tmpfs
In-Reply-To: <200309032254.50468@sercond.localdomain>
Message-ID: <Pine.LNX.4.44.0309031959100.2540-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Sep 2003, Nikita V. Youshchenko wrote:
> Until today I thought that it is a good administration style to create a 
> several gigabyte swap partition (which is normally almost unused, but 
> just for the case that some program needs much virtual memory), and use 
> tmpfs for /tmp.
> I thought that it is good for two reasons - disk space is not wasted for 
> /tmp (and /tmp still has several gigabytes of space), and short-living 
> temporary files such as gcc intermediate files normally reside in memory, 
> which is more effective than using a filesystem on a disk.
> 
> If I understand you correctly, the above is not true at least for a 
> desktop system with 256M of RAM?

I think it's unusual for a machine with 256M of RAM to use more
than ~512M for swap, but I certainly wouldn't advise you against it.
If you've plenty of spare disk, and you find that sometimes it is
almost all useful for swap, keep it that way.  But I can't pretend
that tmpfs is efficient compared with other filesystems once it
gets into using swap.

> And what about LTSP server with 2 gigabytes of RAM (and 6 gigabytes of 
> swap) that normally runs 10-15 KDE sessions with mozilla's and 
> openoffice's?

Sorry, you'll know much more about configuring such systems than I do.

Hugh

