Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263590AbTFDRr3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 13:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263597AbTFDRr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 13:47:29 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:37127 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S263590AbTFDRr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 13:47:28 -0400
Subject: Re: 2.5.70-mm4
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Paul Larson <plars@linuxtestproject.org>
Cc: Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <1054741940.8438.175.camel@plars>
References: <20030603231827.0e635332.akpm@digeo.com>
	 <1054741940.8438.175.camel@plars>
Content-Type: text/plain
Message-Id: <1054749653.699.3.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 04 Jun 2003 20:00:53 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-04 at 17:52, Paul Larson wrote:
> On Wed, 2003-06-04 at 01:18, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.70/2.5.70-mm4/
> A couple of issues:
> 
> Hangs on boot unless I use acpi=off, but I don't believe this is unique
> to -mm.  I've seen this on plain 2.5 kernels on and off before with this
> 8-way and others like it.  AFAIK the acpi issues are ongoing and still
> being worked, but please let me know if there's any information I can
> gather other than what's already out there that would assist in fixing
> these.

This remembers me of a pretty strange issue I'm having with ACPI on my
NEC/Packard Bell Chrom@ laptop: if I plug my 3Com CardBus NIC in the
second PCMCIA slot, the kernel hangs during boot just at the time the
NIC generates an interrupt (for example, by sending a ping or some
traffic). However, if I plug the NIC into the first slot, it works
perfectly.

Curious, isn't it? I think it's related to ACPI IRQ routing: the NIC
uses IRQ10 when plugged into the first slot, but it uses IRQ5 when
plugged into the second one (which causes the mentioned hang). IRQ5 is
being shared with my YMFPCI sound card. Don't know if this is related to
the hangs, but I thought it was worth saying.

