Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274962AbTHKXic (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 19:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274963AbTHKXic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 19:38:32 -0400
Received: from holomorphy.com ([66.224.33.161]:53419 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S274962AbTHKXia (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 19:38:30 -0400
Date: Mon, 11 Aug 2003 16:39:43 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test3-mm1
Message-ID: <20030811233943.GI32488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030811113943.47e5fd85.akpm@osdl.org> <873510000.1060633024@flay> <20030811221628.GR1715@holomorphy.com> <884580000.1060642229@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <884580000.1060642229@flay>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Aug 11, 2003 at 01:17:04PM -0700, Martin J. Bligh wrote:
>> kpmd_ctor() is unusual; how many runs does this profile represent?
>> Does it represent the first run? Ideally, all your kernel pmd's should
>> be cached. If it's not the first run, then logged slab cache statistics
>> would be interesting to determine whether this is still the case even
>> while effective cacheing is going on or whether slab cache reaping is
>> blowing these things away (i.e. either ineffective cacheing is happening
>> or for some reason cacheing them isn't good enough).

On Mon, Aug 11, 2003 at 03:50:29PM -0700, Martin J. Bligh wrote:
> It's the average of 5 runs, after an initial warmup run which is discarded.


Okay, logging /proc/slabinfo and /proc/meminfo at various points
throughout the run would be helpful here.


-- wli
