Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267571AbUG3CRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267571AbUG3CRI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 22:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267576AbUG3CRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 22:17:07 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:59010 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S267571AbUG3CRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 22:17:05 -0400
Date: Fri, 30 Jul 2004 04:16:39 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] mlock-as-nonroot revisted
Message-ID: <20040730021639.GB30369@dualathlon.random>
References: <20040729100307.GA23571@devserv.devel.redhat.com> <20040729142829.2a75c9b9.akpm@osdl.org> <20040729214053.GJ15895@dualathlon.random> <Pine.LNX.4.58.0407292047550.9228@dhcp030.home.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0407292047550.9228@dhcp030.home.surriel.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 08:50:16PM -0400, Rik van Riel wrote:
> please read it first, especially the changes to shmem.c ;)

I read it, and it was obviously still broken.

I got CC direct from Andrew and I read only Andrew's comment and the
code, and I could stop reading the code pretty quick since hugetlbfs is
at the top and very well visibly broken.

chown on tmpfs and hugetlbfs sounds "interesting" with your approch,
I'm looking forward to the next fixed revision. I'm not against per-user
myself, but it's not like doing it for transient memory or transient
objects associated with the task itself. Furthemore I'm not convinced
rlimits should be used for such persistent things that have nothing to
do with running tasks but ok, I can live with it if it works.

I tend to believe if something we should use fs_quota in tmpfs and
hugetlbfs for such things. That is the place to catch chown etc..
