Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWBFIYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWBFIYT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 03:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWBFIYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 03:24:19 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:43225 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750761AbWBFIYT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 03:24:19 -0500
Date: Mon, 6 Feb 2006 09:22:58 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net,
       ak@suse.de, linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-ID: <20060206082258.GA1991@elte.hu>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com> <20060204154944.36387a86.akpm@osdl.org> <20060205203358.1fdcea43.akpm@osdl.org> <20060205215052.c5ab1651.pj@sgi.com> <20060205220204.194ba477.akpm@osdl.org> <20060206061743.GA14679@elte.hu> <20060205232253.ddbf02d7.pj@sgi.com> <20060206074334.GA28035@elte.hu> <20060206001959.394b33bc.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060206001959.394b33bc.pj@sgi.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul Jackson <pj@sgi.com> wrote:

> Ingo wrote:
> > Could you perhaps outline two actual use-cases 
> > that would need two cpusets with different policies,
> > on the same box?
> 
> We normally run with different policies, in the same box, on different 
> cpusets at the same time.  But this might be because some cpusets 
> -need- the memory spreading, and the others that don't are left to the 
> default policy.

so in practice, the memory spreading is in fact a global setting, used
by all cpusets that matter? That seems to support Andrew's observation
that our assumptions / defaults are bad, pretty much independently of
the workload.

	Ingo
