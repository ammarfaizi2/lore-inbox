Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270854AbTHFR2E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 13:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270865AbTHFR2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 13:28:04 -0400
Received: from holomorphy.com ([66.224.33.161]:20621 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S270854AbTHFR0M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 13:26:12 -0400
Date: Wed, 6 Aug 2003 10:27:21 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2.6-mm] fix any_online_cpu() with cpumask_t and NR_CPUS < BITS_PER_LONG
Message-ID: <20030806172721.GV32488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.53.0308060608590.7244@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0308060608590.7244@montezuma.mastecende.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 06:23:20AM -0400, Zwane Mwaikambo wrote:
> I have no idea how this slipped in, all my boxes couldn't boot, the thing 
> is it'll boot on 2way but as soon as you get to cpu2 you're shafted. 
> Tested on 3x and 8x. The problem is that we really want to find the first 
> cpu in the map and not whether there are processors in the map.

There's more where that came from. I've not done quite as good a job of
tracking the fixes as sending them upstream.

Basically:
(a) any_online_cpu()
(b) cpus_shift_left()
(c) cpu_set()/cpu_clear() need atomicity
(d) something else that's really obvious from looking

all needed fixes, and should have all had stuff sent upstream/to akpm.


-- wli
