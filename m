Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267767AbUG3SI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267767AbUG3SI1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 14:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267771AbUG3SI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 14:08:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:989 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267769AbUG3SIY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 14:08:24 -0400
Message-ID: <410A8E7D.2030009@pobox.com>
Date: Fri, 30 Jul 2004 14:07:57 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org,
       James.Bottomley@HansenPartnership.com
Subject: Re: [PATCH] Improve pci_alloc_consistent wrapper on preemptive kernels
References: <20040730190227.29913e23.ak@suse.de>	<410A826C.4000508@pobox.com> <20040730194304.2c27f48c.ak@suse.de>
In-Reply-To: <20040730194304.2c27f48c.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Fri, 30 Jul 2004 13:16:28 -0400
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
> 
> 
>>1) Changing from GFP_ATOMIC to <something else> may break code
> 
> 
> x86-64 did it for a long time and I am not aware of problems with it
> (however I don't know how widespread CONFIG_PREEMPT use on x86-64 is) 
> 
> 
>>2) Conversely from #1, I also worry why GFP_ATOMIC would be needed at 
>>all.  I code all my drivers to require that pci_alloc_consistent() be 
>>called from somewhere that is allowed to sleep.
> 
> 
> Maybe you do, but others don't.

Certainly.  Therefore, changing from GFP_ATOMIC will increase likelihood 
of breakage, no?

	Jeff



