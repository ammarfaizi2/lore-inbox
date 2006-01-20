Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbWATTzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWATTzZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 14:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWATTzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 14:55:25 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:2489
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932119AbWATTzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 14:55:24 -0500
Date: Fri, 20 Jan 2006 11:52:47 -0800 (PST)
Message-Id: <20060120.115247.111667905.davem@davemloft.net>
To: Valdis.Kletnieks@vt.edu
Cc: xslaby@fi.muni.cz, akpm@osdl.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: Iptables error
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200601201813.k0KIDa6B003760@turing-police.cc.vt.edu>
References: <20060120162317.5F70722B383@anxur.fi.muni.cz>
	<200601201813.k0KIDa6B003760@turing-police.cc.vt.edu>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valdis.Kletnieks@vt.edu
Date: Fri, 20 Jan 2006 13:13:36 -0500

> Confirmed here.  Backing out this one-liner makes iptables work for me.
> i686 on a Pentium-4, gcc 4.1.0 from Fedora -devel tree.

Ok this is on x86.  I think I see how it breaks, but I thought
Harald's patch would have the same problem.

I just ran a test program, and indeed __alignof__() gives 8
for "long long" and 4 for a struct containing a "long long"
on x86.  Yikes...

Linus is likely about to be on his way to the airport so I'll
push the fix in New Zealand.
