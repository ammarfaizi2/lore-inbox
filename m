Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264534AbTH2LI4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 07:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264533AbTH2LI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 07:08:56 -0400
Received: from ns.suse.de ([195.135.220.2]:29914 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264534AbTH2LIz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 07:08:55 -0400
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
References: <20030829053510.GA12663@mail.jlokier.co.uk.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 29 Aug 2003 13:08:51 +0200
In-Reply-To: <20030829053510.GA12663@mail.jlokier.co.uk.suse.lists.linux.kernel>
Message-ID: <p733cfkpvp8.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

> I already got a surprise (to me): my Athlon MP is much slower
> accessing multiple mappings which are within 32k of each other, than
> mappings which are further apart, although it is coherent.  The L1

Most x86 and probably most other modern CPUs have virtually addressed L1 caches.
It's just too slow to wait for the MMU for an L1 access which is really critical.

So such artifacts are expected

> data cache is 64k.  (The explanation is easy: virtually indexed,
> physically tagged cache moves data among cache lines, possibly via L2).

On x86 L2 is usually physically tagged.

Mostly only ARM,MIPS et.al. have virtually tagged L2.

-Andi
