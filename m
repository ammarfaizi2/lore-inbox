Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbVFMWw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVFMWw0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 18:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbVFMWuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 18:50:46 -0400
Received: from cantor2.suse.de ([195.135.220.15]:21916 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261602AbVFMWro (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 18:47:44 -0400
Date: Tue, 14 Jun 2005 00:47:40 +0200
From: Andi Kleen <ak@suse.de>
To: "Langsdorf, Mark" <mark.langsdorf@amd.com>
Cc: Tom Duffy <tduffy@sun.com>, discuss@x86-64.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [discuss] [OOPS] powernow on smp dual core amd64
Message-ID: <20050613224740.GJ21345@wotan.suse.de>
References: <84EA05E2CA77634C82730353CBE3A84301CFC14D@SAUSEXMB1.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84EA05E2CA77634C82730353CBE3A84301CFC14D@SAUSEXMB1.amd.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Unfortunately, after starting cpuspeed daemon, I get this:
> 
> It looks like it's happening sometime after cpuspeed starts.
> Could you disable cpuspeed and see if the problem still
> occurs? 

If anything it must be something in the kernel (except someone
does very strange stuff in /dev/mem) 

> 
> > Starting cpuspeed: [  OK  ]
> > Starting pcmcia:  Starting PCMCIA services:
> > CPU 6: Machine Check Exception:                4 Bank 4: 
> > b200000000070f0f
> > TSC 4129a3d70d
> 
> > Code:  Bad RIP value.
> > RIP [<00000000000000ff>] RSP <ffff81003fe63fa0>
> > CR2: 00000000000000ff
> >  <0>Kernel panic - not syncing: Oops
> 
> Andi said that "Something tried to access a physical memory 
> address that was not mapped in the CPU."  Andi, is this
> related to the bug that you thought might have been fixed
> in 2.6.12-rc6-git4?

No, I don't think so. In that bug something would be mapped
twice, not nothing. Also nobody reported watchdog timeouts
for that one.

-Andi
