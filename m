Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263289AbVCKClO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263289AbVCKClO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 21:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263294AbVCKClN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 21:41:13 -0500
Received: from fire.osdl.org ([65.172.181.4]:8892 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263292AbVCKCkZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 21:40:25 -0500
Date: Thu, 10 Mar 2005 18:42:10 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>
cc: Dave Jones <davej@redhat.com>, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org
Subject: Re: AGP bogosities
In-Reply-To: <16944.65532.632559.277927@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.58.0503101839530.2530@ppc970.osdl.org>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
 <20050311021248.GA20697@redhat.com> <16944.65532.632559.277927@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 11 Mar 2005, Paul Mackerras wrote:
> 
> The point is that pci_get_class does a pci_dev_put() on the "from"
> parameter, so your code ended up doing a double put.

Ahh, I missed that too. 

Hmm.. We seem to not have any tests for the counts becoming negative, and
this would seem to be an easy mistake to make considering that both I and 
Dave did it.

		Linus
