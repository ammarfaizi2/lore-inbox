Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755410AbWKNFHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755410AbWKNFHm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 00:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755411AbWKNFHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 00:07:42 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:15842
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1755410AbWKNFHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 00:07:41 -0500
Date: Mon, 13 Nov 2006 21:07:50 -0800 (PST)
Message-Id: <20061113.210750.66175955.davem@davemloft.net>
To: benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, anton@samba.org,
       airlied@gmail.com, idr@us.ibm.com, paulus@samba.org
Subject: Re: [PATCH/RFC] powerpc: Fix mmap of PCI resource with hack for X
From: David Miller <davem@davemloft.net>
In-Reply-To: <1163469594.5940.42.camel@localhost.localdomain>
References: <1163405790.4982.289.camel@localhost.localdomain>
	<20061113.163138.98554015.davem@davemloft.net>
	<1163469594.5940.42.camel@localhost.localdomain>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 14 Nov 2006 12:59:54 +1100

> If I "fix" the kernel to do the right thing, that is pass BAR values in
> devices and expect BAR values in mmap, then I will break existing X
> setups on machines where PCI is not mapped 1:1 (that is mostly CHRP
> machines).
> 
> The problem I'm fixing in this patch is that while we were providing the
> hacked up value in "devices", we were expecting the BAR value in mmap,
> and there are apps expecting us to be consistent between the two, thus
> the breakage.

Ok, I don't see much alternatives for you then.  I have no real
objections to your patch.
