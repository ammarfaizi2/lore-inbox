Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbWEBUAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWEBUAU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 16:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWEBUAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 16:00:20 -0400
Received: from cantor.suse.de ([195.135.220.2]:23513 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751275AbWEBUAT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 16:00:19 -0400
From: Andi Kleen <ak@suse.de>
To: Martin Bligh <mbligh@mbligh.org>
Subject: Re: assert/crash in __rmqueue() when enabling CONFIG_NUMA
Date: Tue, 2 May 2006 22:00:12 +0200
User-Agent: KMail/1.9.1
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
References: <20060419112130.GA22648@elte.hu> <200605022144.56586.ak@suse.de> <4457B960.40701@mbligh.org>
In-Reply-To: <4457B960.40701@mbligh.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605022200.12980.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 May 2006 21:56, Martin Bligh wrote:
> Andi Kleen wrote:
> > On Tuesday 02 May 2006 21:48, Ingo Molnar wrote:
> > 
> >>* Andi Kleen <ak@suse.de> wrote:
> >>
> >>
> >>>i386: Panic the system early when a NUMA kernel doesn't run on IBM 
> >>>NUMA
> >>
> >>nah! Lets just fix the zone sizing bug ...
> > 
> > 
> > The problem is that nobody regression tests it. So even if you fix it
> > now it will be likely broken again in a few months.
> 
> We can add a box to the test.kernel.org harness easily enough, and
> it will show up with an eerie red glow.

Single box is not enough - there are many possible combinations
(e.g. Opteron NUMA, IBM NUMA, no NUMA small box, big box with weird
mappings etc.). Basically you would need a real tester base.

-Andi
