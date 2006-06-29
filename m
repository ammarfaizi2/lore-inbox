Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932617AbWF2Kzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932617AbWF2Kzy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 06:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932709AbWF2Kzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 06:55:54 -0400
Received: from mail.suse.de ([195.135.220.2]:45541 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932617AbWF2Kzx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 06:55:53 -0400
From: Andi Kleen <ak@suse.de>
To: Milena Milenkovic <mmilenko@us.ibm.com>
Subject: Re: [2.6 PATCH] Exporting mmu_cr4_features again for i386 & x86_64
Date: Thu, 29 Jun 2006 12:55:36 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk, hpa@zytor.com
References: <OF692619AF.8A926C55-ON8725719B.007C1C06-8625719B.007E27C7@us.ibm.com>
In-Reply-To: <OF692619AF.8A926C55-ON8725719B.007C1C06-8625719B.007E27C7@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606291255.36206.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 June 2006 01:01, Milena Milenkovic wrote:
> Hi all,
> 
> The mmu_cr4_features variable was "unexported" in 2.6.12 kernel
> (A patch submitted by Adrian Bunk, [2.6 patch] unexport mmu_cr4_features).

Normal policy is to unexport symbols that are not used in the core 
kernel.

However I think there is a deprecation policy with prior 
warning that might not have been followed here.

> However, this variable is needed if a loadable kernel module wants to 
> enable
> access to performance counters from user space.

Ok I guess it's a reasonable request (although we will likely
eventually add a standard API for this and then it might 
be removed again) 


-Andi
