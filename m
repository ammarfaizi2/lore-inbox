Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267372AbUIHNFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267372AbUIHNFg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 09:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbUIHNBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 09:01:48 -0400
Received: from holomorphy.com ([207.189.100.168]:56999 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267455AbUIHM6H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 08:58:07 -0400
Date: Wed, 8 Sep 2004 05:57:55 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Scott Wood <scott@timesys.com>
Subject: Re: [patch] generic-hardirqs.patch, 2.6.9-rc1-bk14
Message-ID: <20040908125755.GC3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Scott Wood <scott@timesys.com>
References: <20040908120613.GA16916@elte.hu> <20040908133445.A31267@infradead.org> <20040908124547.GA19231@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908124547.GA19231@elte.hu>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Christoph Hellwig <hch@infradead.org> wrote:
>> And make hardirq.o dependent on some symbols the architectures set.
>> Else arches that don't use it carry tons of useless baggage around
>> (and in fact I'm pretty sure it wouldn't even compie for many)

On Wed, Sep 08, 2004 at 02:45:47PM +0200, Ingo Molnar wrote:
> it compiles fine on x86, x64, ppc and ppc64. Why do you think it wont
> compile on others?
> wrt. unused generic functions - why dont we drop them link-time?

It may be time for a __weak define to abbreviate __attribute__((weak));
we seem to use it in enough places.


-- wli
