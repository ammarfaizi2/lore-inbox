Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270605AbTHAAOY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 20:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270618AbTHAAOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 20:14:23 -0400
Received: from holomorphy.com ([66.224.33.161]:28122 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S270605AbTHAAOW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 20:14:22 -0400
Date: Thu, 31 Jul 2003 17:15:38 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: Panic on 2.6.0-test1-mm1
Message-ID: <20030801001538.GK15452@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, mbligh@aracnet.com,
	linux-kernel@vger.kernel.org
References: <5110000.1059489420@[10.10.2.4]> <20030731223710.GI15452@holomorphy.com> <20030731224148.GJ15452@holomorphy.com> <20030731154020.61e15723.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030731154020.61e15723.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> You may now put the "aggravated" magnet beneath the "wli" position on
>> the fridge.

On Thu, Jul 31, 2003 at 03:40:20PM -0700, Andrew Morton wrote:
> I never, ever, at any stage was told that highpmd.patch offered any
> benefits wrt lock contention or node locality.  I was only told that it
> saved a little bit of memory on highmem boxes.

The lock contention is unrelated apart from the mangling of pgd_ctor().
The node locality is only important on systems with exaggerated NUMA
characteristics, such as the kind Martin and I bench on.


On Thu, Jul 31, 2003 at 03:40:20PM -0700, Andrew Morton wrote:
> It would be useful to actually tell me what your patches do.  And to
> provide test results which demonstrate the magnitude of the performance
> benefits.

I don't believe it would be valuable to push it on the grounds of
performance, as the performance characteristics of modern midrange i386
systems don't have such high remote access penalties.

The complaint was targetted more at errors in some new incoming patch
motivating mine being backed out.


-- wli
