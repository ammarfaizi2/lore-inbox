Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274905AbTHABBH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 21:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274910AbTHABBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 21:01:07 -0400
Received: from holomorphy.com ([66.224.33.161]:44250 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S274905AbTHABBF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 21:01:05 -0400
Date: Thu, 31 Jul 2003 18:02:16 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Panic on 2.6.0-test1-mm1
Message-ID: <20030801010216.GN15452@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Andrew Morton <akpm@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <5110000.1059489420@[10.10.2.4]> <20030731223710.GI15452@holomorphy.com> <390810000.1059698875@flay> <20030801005310.GM15452@holomorphy.com> <393910000.1059699469@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <393910000.1059699469@flay>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> pgd_dtor() will never be called on PAE due to the above code (thanks to
>> the PTRS_PER_PMD check), _unless_ mingo's patch is applied (which backs
>> out the PTRS_PER_PMD check).

On Thu, Jul 31, 2003 at 05:57:49PM -0700, Martin J. Bligh wrote:
> OK, might have made a mistake ... I can rerun it if you want, but the 
> latest kernel seems to work now.

There was a spinlock acquisition in there, too, so if you're seeing
weird performance effects in an update (not sure if there are any yet),
generating a patch to skip that, the list op, and not install pgd_dtor()
when PTRS_PER_PMD == 1 is in order.


-- wli
