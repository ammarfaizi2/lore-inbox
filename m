Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751031AbVHSDTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbVHSDTj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 23:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbVHSDTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 23:19:38 -0400
Received: from ns1.suse.de ([195.135.220.2]:47043 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751031AbVHSDTi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 23:19:38 -0400
To: Bernardo Innocenti <bernie@develer.com>
Cc: linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: Re: sched_yield() makes OpenLDAP slow
References: <4303DB48.8010902@develer.com.suse.lists.linux.kernel>
	<20050818010703.GA13127@nineveh.rivenstone.net.suse.lists.linux.kernel>
	<4303F967.6000404@yahoo.com.au.suse.lists.linux.kernel>
	<43054D9A.7090509@develer.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 19 Aug 2005 05:19:37 +0200
In-Reply-To: <43054D9A.7090509@develer.com.suse.lists.linux.kernel>
Message-ID: <p73oe7usjee.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernardo Innocenti <bernie@develer.com> writes:

It's really more a feature than a bug that it breaks so easily
because they should be really using futexes instead, which
have much better behaviour than any sched_yield ever could
(they will directly wake up another process waiting for the
lock and avoid the thundering herd for contended locks) 

-Andi
