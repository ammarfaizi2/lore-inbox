Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751805AbWEFAes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbWEFAes (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 20:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbWEFAes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 20:34:48 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:1743
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751801AbWEFAer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 20:34:47 -0400
Date: Fri, 05 May 2006 17:34:49 -0700 (PDT)
Message-Id: <20060505.173449.83405876.davem@davemloft.net>
To: errandir_news@mph.eclipse.co.uk
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: sparc: cannot load any modules with 2.6.17-rc3
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060505113514.GA28863@palantir8>
References: <20060505113514.GA28863@palantir8>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Fri, 5 May 2006 12:35:14 +0100

> When I try to boot 2.6.17-rc3 on my SS20 I get this error for every
> module it tries to load:
>   module crc32: Unknown relocation: 17
> 
> This worked okay on 2.6.16-rc2. Is anyone looking into this problem yet?
> It's comming from a new type R_SPARC_PC22 in the ELF header. Any idea
> what could be causing this? Is it intentional or a bug?
> 
> I've attached my dmesg output and the config. Please CC me as I'm not
> subscribed to linux-kernel.

I don't see how that type of relocation can be emitted.
Can you send me one of the smaller of the *.ko files that
have this problem?  Thanks.

I can add the relocation handling to the Sparc module support,
but I don't think it should be necessary in the first place
and looking at a sample module with the problem will help me
figure this out.
