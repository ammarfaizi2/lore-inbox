Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932529AbVLMHd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbVLMHd0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 02:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932530AbVLMHd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 02:33:26 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:49863 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932529AbVLMHdZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 02:33:25 -0500
Date: Tue, 13 Dec 2005 08:32:24 +0100
From: Ingo Molnar <mingo@elte.hu>
To: John Hawkes <hawkes@sgi.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Dinakar Guniguntala <dino@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Jack Steiner <steiner@sgi.com>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [patch -mm] scheduler cache hot autodetect, isolcpus fix
Message-ID: <20051213073224.GA5862@elte.hu>
References: <20051209205454.18325.46768.sendpatchset@tomahawk.engr.sgi.com> <20051210122548.GB25065@elte.hu> <00a401c5ff59$7958c480$6f00a8c0@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00a401c5ff59$7958c480$6f00a8c0@comcast.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.7
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.7 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* John Hawkes <hawkes@sgi.com> wrote:

> I'm looking at 2.6.15-rc5-mm2 and there is still a problem: the 
> migration_cost[] array is disappearing after boot, which leads to 
> completely bogus migration_cost[] values when dynamic sched domains 
> are declared.

oops, indeed!

> -static __initdata unsigned long long migration_cost[MAX_DOMAIN_DISTANCE] =
> +static unsigned long long migration_cost[MAX_DOMAIN_DISTANCE] =

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
