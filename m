Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965013AbWBGK4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965013AbWBGK4o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 05:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965005AbWBGK4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 05:56:44 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:934
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965013AbWBGK4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 05:56:43 -0500
Date: Tue, 07 Feb 2006 02:56:33 -0800 (PST)
Message-Id: <20060207.025633.75253203.davem@davemloft.net>
To: ak@suse.de
Cc: sfr@canb.auug.org.au, akpm@osdl.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH] compat: add compat functions for *at syscalls
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200602071039.52490.ak@suse.de>
References: <20060207112713.7cd0a61c.sfr@canb.auug.org.au>
	<20060207.004301.35467668.davem@davemloft.net>
	<200602071039.52490.ak@suse.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@suse.de>
Date: Tue, 7 Feb 2006 10:39:52 +0100

> My impression is you're doing a lot of ugly code here just to 
> work around some pecularity of the sparc gcc. 

No, I'm simply sign extending arguments that need to
be signed.  PPC and other platforms do this too, just with
C code.  Actually I think s390x uses assembler stubs as well.
