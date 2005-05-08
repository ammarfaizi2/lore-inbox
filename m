Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262862AbVEHNYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262862AbVEHNYk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 09:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262865AbVEHNYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 09:24:39 -0400
Received: from one.firstfloor.org ([213.235.205.2]:15081 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262862AbVEHNYb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 09:24:31 -0400
To: 7eggert@gmx.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/cpuinfo format - arch dependent!
References: <3UZS7-5ue-17@gated-at.bofh.it> <41ouh-4QE-1@gated-at.bofh.it>
	<41oXl-5hl-7@gated-at.bofh.it> <41sxX-8cN-11@gated-at.bofh.it>
	<41BL4-7l7-15@gated-at.bofh.it>
	<E1DUYnC-0001Hd-5g@be1.7eggert.dyndns.org>
From: Andi Kleen <ak@muc.de>
Date: Sun, 08 May 2005 15:24:30 +0200
In-Reply-To: <E1DUYnC-0001Hd-5g@be1.7eggert.dyndns.org> (Bodo Eggert's
 message of "Sun, 08 May 2005 01:33:05 +0200")
Message-ID: <m1zmv5voj5.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" <7eggert@gmx.de> writes:

>
> Obviously it must be a tree of CPU groups. CPUs in one NUMA node go into
> one group, multi-core CPUs have all cores in one group and HT is a group,
> too. This will scale from UP (degenerated tree with just one CPU) to
> clusters with multicore HT-capable CPUs on PCI boards.

All this informtation (except HT/multicore are folded into a single
level) is already there in sysfs.

libnuma uses it to discover the topology and report it to the
user.


-Andi
