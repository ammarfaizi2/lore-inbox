Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261431AbVDWBuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbVDWBuK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 21:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbVDWBuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 21:50:10 -0400
Received: from fire.osdl.org ([65.172.181.4]:10650 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261431AbVDWBuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 21:50:06 -0400
Date: Fri, 22 Apr 2005 18:51:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Rohit Seth <rohit.seth@intel.com>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Increase number of e820 entries hard limit from 32 to
 128
In-Reply-To: <20050422181441.A18205@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.58.0504221851140.2344@ppc970.osdl.org>
References: <20050422181441.A18205@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 22 Apr 2005, Venkatesh Pallipadi wrote:
> 
> The specifications that talk about E820 map doesn't have an upper limit
> on the number of E820 entries. But, today's kernel has a hard limit of 32.
> With increase in memory size, we are seeing the number of E820 entries
> reaching close to 32. Patch below bumps the number upto 128. 

Hmm. Anything that changes setup.S tends to have bootloader dependencies. 
I worry whether this one does too..

		Linus
