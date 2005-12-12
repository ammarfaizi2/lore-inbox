Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751064AbVLLD3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbVLLD3G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 22:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbVLLD3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 22:29:05 -0500
Received: from mail.suse.de ([195.135.220.2]:40863 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751064AbVLLD3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 22:29:04 -0500
Date: Mon, 12 Dec 2005 04:29:03 +0100
From: Andi Kleen <ak@suse.de>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, Simon Derr <Simon.Derr@bull.net>,
       Andi Kleen <ak@suse.de>, Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH] Cpuset: rcu optimization of page alloc hook
Message-ID: <20051212032902.GW11190@wotan.suse.de>
References: <20051211233130.18000.2748.sendpatchset@jackhammer.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051211233130.18000.2748.sendpatchset@jackhammer.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks to Andi Kleen and Nick Piggin for the suggestion.

Thanks. But i guess it would be still a good idea to turn
ia "check that there is no cpuset" test into an inline
so that it can be done without a function call. Only when
it fails call the out of line cpuset full checking function.

This would make the common case of a kernel with cpuset
compiled in but nobody using it faster.

This could be done even without any memory barriers of
any kind.

-Andi
