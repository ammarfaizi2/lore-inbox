Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263228AbTDVQ4R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 12:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263234AbTDVQ4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 12:56:16 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:11329 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263228AbTDVQ4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 12:56:05 -0400
Date: Tue, 22 Apr 2003 13:07:57 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@digeo.com>,
       Andrea Arcangeli <andrea@suse.de>, <mingo@elte.hu>, <hugh@veritas.com>,
       <dmccr@us.ibm.com>, Linus Torvalds <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: objrmap and vmtruncate
In-Reply-To: <20030422165842.GG8931@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0304221303160.24424-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 22 Apr 2003, William Lee Irwin III wrote:

> ISTR it being something on the order of running 32 instances of top(1),
> one per cpu, and then trying to fork().

oh, have you run any of the /proc fixes floating around? It still has some
pretty bad (quadratic) stuff left in, and done under tasklist_lock
read-help - if any write_lock_irq() of the tasklist lock hits this code
then you get an NMI assert. Please try either Manfred's or mine.

	Ingo


