Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbTHZO1h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 10:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263733AbTHZOYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 10:24:37 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:58498 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S264186AbTHZOXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 10:23:48 -0400
Date: Tue, 26 Aug 2003 07:23:10 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4-mm1
Message-ID: <9910000.1061907789@[10.10.2.4]>
In-Reply-To: <20030826100824.GQ4306@holomorphy.com>
References: <20030824171318.4acf1182.akpm@osdl.org> <30190000.1061853042@flay> <20030826100824.GQ4306@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--William Lee Irwin III <wli@holomorphy.com> wrote (on Tuesday, August 26, 2003 03:08:24 -0700):

> On Mon, Aug 25, 2003 at 04:10:42PM -0700, Martin J. Bligh wrote:
>>       7763     4.8% total
>>       2921     6.4% default_idle
>>        949     0.0% direct_strnlen_user
>>        719    20.6% __copy_from_user_ll
>>        554    10.4% __copy_to_user_ll
>>        544    33.5% kmem_cache_free
>>        425     0.0% kpmd_ctor
>>        372    26.1% schedule
>>        349    18.7% atomic_dec_and_lock
>>        322     4.1% __d_lookup
>>        318     8.6% find_get_page
>>        283   165.5% may_open
> 
> Hmm, seeing functions I wrote in diffprofiles like this gives me the
> wli's. Any chance you could snapshot /proc/slabinfo say every 1s during
> a run so I can see what's going on?

You should be able to recreate this easily yourself, but on closer
inspection, it seems the cost is just shifted from pgd_ctor.

M.

