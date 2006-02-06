Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWBFHou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWBFHou (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 02:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbWBFHou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 02:44:50 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:28070 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750725AbWBFHot (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 02:44:49 -0500
Date: Mon, 6 Feb 2006 08:43:34 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net,
       ak@suse.de, linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-ID: <20060206074334.GA28035@elte.hu>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com> <20060204154944.36387a86.akpm@osdl.org> <20060205203358.1fdcea43.akpm@osdl.org> <20060205215052.c5ab1651.pj@sgi.com> <20060205220204.194ba477.akpm@osdl.org> <20060206061743.GA14679@elte.hu> <20060205232253.ddbf02d7.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060205232253.ddbf02d7.pj@sgi.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul Jackson <pj@sgi.com> wrote:

> The tasks we are talking about do -not- want a default RANDOM policy.  
> They want node-local allocation for per-thread data (data and stack 
> for example), and at the same time spread allocation for kernel space 
> (page and slab cache).

ok, i think i got that. Could you perhaps outline two actual use-cases 
that would need two cpusets with different policies, on the same box? Or 
would you set the spread-out policy for every cpuset that is used in a 
box with lots of cpusets, to achieve fairness? (and not bother about it 
on boxes with dedicated workloads)

	Ingo
