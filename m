Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268335AbUIWJDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268335AbUIWJDz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 05:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268333AbUIWJDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 05:03:55 -0400
Received: from cantor.suse.de ([195.135.220.2]:45994 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268326AbUIWJDx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 05:03:53 -0400
Date: Thu, 23 Sep 2004 11:03:45 +0200
From: Andi Kleen <ak@suse.de>
To: Andy Lutomirski <luto@myrealbox.com>
Cc: Andi Kleen <ak@suse.de>, Christoph Lameter <clameter@sgi.com>,
       akpm@osdl.org, "David S. Miller" <davem@davemloft.net>,
       benh@kernel.crashing.org, wli@holomorphy.com, davem@redhat.com,
       raybry@sgi.com, ak@muc.de, manfred@colorfullife.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       vrajesh@umich.edu, hugh@veritas.com
Subject: Re: page fault scalability patch V8: [4/7] universally available cmpxchg on i386
Message-ID: <20040923090345.GA6146@wotan.suse.de>
References: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0409201348070.4628@schroedinger.engr.sgi.com> <20040920205752.GH4242@wotan.suse.de> <200409211841.25507.vda@port.imtp.ilyichevsk.odessa.ua> <20040921154542.GB12132@wotan.suse.de> <41527885.8020402@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41527885.8020402@myrealbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Wouldn't alternative_input() choosing between a cmpxchg and a call be 
> the way to go here?  Or is the overhead too high in an inline function?

It would if you want the absolute micro optimization yes. Disadvantage
is that you would waste some more space for nops in the !CONFIG_I386 case.
I personally don't think it matters much and that Christian's original
code was just fine.

-Andi (last post on the thread) 
