Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131878AbRARFLl>; Thu, 18 Jan 2001 00:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131931AbRARFLb>; Thu, 18 Jan 2001 00:11:31 -0500
Received: from mail.sun.ac.za ([146.232.128.1]:41733 "EHLO mail.sun.ac.za")
	by vger.kernel.org with ESMTP id <S131878AbRARFLV>;
	Thu, 18 Jan 2001 00:11:21 -0500
Date: Thu, 18 Jan 2001 07:11:05 +0200 (SAST)
From: Hans Grobler <grobh@sun.ac.za>
To: Rick Richardson <rick@remotepoint.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: kmalloc() of 4MB causes "kernel BUG at slab.c:1542!"
In-Reply-To: <20010117135420.A3536@remotepoint.com>
Message-ID: <Pine.LNX.4.30.0101180703030.9300-100000@prime.sun.ac.za>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jan 2001, Rick Richardson wrote:
> Problem:  kmalloc() of 4M causes kernel message "kernel BUG at slab.c:1542"

This BUG() has been been removed in the later -ac patches as it was meant
to be a temporary debugging help during the -test3 slab.c changes. This
does not however remove the constraint that kmalloc can only allocate a
maximum of 128KB. How you solve this will depend what you want to use the
memory for.

-- Hans


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
