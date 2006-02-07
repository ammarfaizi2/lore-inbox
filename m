Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965062AbWBGMtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965062AbWBGMtX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 07:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965063AbWBGMtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 07:49:23 -0500
Received: from ns1.suse.de ([195.135.220.2]:51170 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965062AbWBGMtX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 07:49:23 -0500
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>, steiner@sgi.com
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Date: Tue, 7 Feb 2006 13:43:58 +0100
User-Agent: KMail/1.8.2
Cc: Paul Jackson <pj@sgi.com>, clameter@engr.sgi.com, akpm@osdl.org,
       dgc@sgi.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com> <200602071314.34879.ak@suse.de> <20060207123001.GA634@elte.hu>
In-Reply-To: <20060207123001.GA634@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602071343.59384.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 February 2006 13:30, Ingo Molnar wrote:

> you are a bit biased towards low-latency NUMA setups i guess (read: 
> Opterons) :-) 

Well they are the vast majority of NUMA systems Linux runs on.
And there are more than just Opterons, e.g. IBM Summit. And even
the majority of Altixes are not _that_ big.

Of course we need to deal somehow with the big systems, but
for the good defaults the smaller systems are more important.
Big systems tend to have capable administrators who
are willing to tweak them. But that's rarely the case with
the small systems. So I think as long as the big system
can be somehow made to work with special configuration
and ignoring corner cases that's fine. But for the low 
NUMA systems it should perform as well as possibly out of the box.

> Obviously with a low NUMA factor, we dont have to deal  
> with memory access assymetries all that much.

That is why I proposed "nearby policy". It can turn a system
with a large NUMA factor into a system with a small NUMA factor.

-Andi
