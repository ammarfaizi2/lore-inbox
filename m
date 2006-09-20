Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWITL2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWITL2N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 07:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWITL2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 07:28:13 -0400
Received: from nf-out-0910.google.com ([64.233.182.131]:2332 "EHLO
	nf-out-f131.google.com") by vger.kernel.org with ESMTP
	id S1750784AbWITL2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 07:28:11 -0400
Message-ID: <5cc6b04e0609200428ja52fa8dl5246488f64d794cb@mail.gmail.com>
Date: Wed, 20 Sep 2006 12:28:10 +0100
From: "Chris Jefferson" <chris@bubblescope.net>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Allocated large blocks of memory on 64 bit linux.
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I apologise for this slightly off-topic message, but I believe it can
best be answered here, and hope the question may be interesting.

Many libraries have some kind of dynamically sized container (for
example C++'s std::vector). When the container is full a new block of
memory, typically double the original size, is allocated and the old
data copied across.

On a 64 bit architecture, where the memory space is massive, it seems
at first glance a sensible thing to do might be to first make a buffer
of size 4k, and then when this fills up, just straight to something
huge, like 1MB or even 1GB, as the memory space is effectively
infinate compared to the physical memory. Obvious most of this buffer
may never be written to, as the object never grows large enough to
fill it.

What is the overhead of allocating memory which is never used? Is this
a sensible course of action on 64-bit architectures?

Thank you
