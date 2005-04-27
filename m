Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbVD0Nrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbVD0Nrt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 09:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261591AbVD0Nps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 09:45:48 -0400
Received: from one.firstfloor.org ([213.235.205.2]:17888 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261547AbVD0NoF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 09:44:05 -0400
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>,
       David Addison <david.addison@quadrics.com>
Subject: Re: [PATCH][RFC] Linux VM hooks for advanced RDMA NICs
References: <426E62ED.5090803@quadrics.com> <426E751A.2020507@ens-lyon.org>
From: Andi Kleen <ak@muc.de>
Date: Wed, 27 Apr 2005 15:43:58 +0200
In-Reply-To: <426E751A.2020507@ens-lyon.org> (Brice Goglin's message of
 "Tue, 26 Apr 2005 19:06:34 +0200")
Message-ID: <m1hdhsxrkx.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brice Goglin <Brice.Goglin@ens-lyon.org> writes:
> I see two drawback in (2).
> First, it requires to play with the list of ioproc_ops when VMA are
> merged or split. Actually, it's not that bad since the list often
> contains only 1 ioproc_ops.

I had a similar problem with the NUMA policies. With some minor hacks
you could probably reuse the policy support by making it a weird kind
of policy.  That would allow to keep the fast path impact very low,
which I think is the most important part of such hardware specific
narrow purpose, useless to 99.9999% of all users hacks 
(Golden rule number 1 such code: dont impact anything else)

-Andi
