Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264324AbTLERoV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 12:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264325AbTLERoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 12:44:20 -0500
Received: from intra.cyclades.com ([64.186.161.6]:24466 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S264324AbTLERoK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 12:44:10 -0500
Date: Fri, 5 Dec 2003 15:12:14 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Ethan Weinstein <lists@stinkfoot.org>, <linux-kernel@vger.kernel.org>
Subject: Re: HT apparently not detected properly on 2.4.23
In-Reply-To: <20031203235837.GW8039@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0312051511440.5412-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Dec 2003, William Lee Irwin III wrote:

> William Lee Irwin III wrote:
> >>You probably have sparse physical APIC ID's.
> 
> On Wed, Dec 03, 2003 at 06:41:36PM -0500, Ethan Weinstein wrote:
> > Ok, setting CONFIG_NR_CPUS=8 does indeed solve the HT issue, looks like 
> > it was the numbering scheme:
> 
> It's easy to fix this; just terminate the loop when the count of cpus
> kicked hits NR_CPUS or the bit would overflow the map instead of the bit
> hitting NR_CPUS. Compare smpboot.c in 2.4 vs. 2.6. No need for the extra
> CONFIG_NR_CPUS bloat.
> 
> 
> On Wed, Dec 03, 2003 at 06:41:36PM -0500, Ethan Weinstein wrote:
> > But we're still only interrupting on CPU0 with this kernel.
> 
> That's P-IV retardation. Not really fixable, but irqbalance daemons
> etc. can help mitigate the severity of the erratum. I'm not sure if
> 2.4 has the interfaces for the userspace solutions to work or the
> kernel solutions either.

I think I will just remove CONFIG_NR_CPUS instead... it seems to bring 
more trouble than advantages. 

