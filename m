Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750973AbVJNJey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbVJNJey (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 05:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbVJNJey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 05:34:54 -0400
Received: from ns1.suse.de ([195.135.220.2]:57321 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750973AbVJNJey (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 05:34:54 -0400
From: Andi Kleen <ak@suse.de>
To: yhlu <yhlu.kernel@gmail.com>
Subject: Re: amd_detect_cmp messing up initial apic id and apic id
Date: Fri, 14 Oct 2005 11:35:06 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <86802c440510140009t239d9dffj62469453db5737e4@mail.gmail.com>
In-Reply-To: <86802c440510140009t239d9dffj62469453db5737e4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510141135.06147.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 October 2005 09:09, yhlu wrote:
> andi,
>
> in arch/x86_64/setup.c amd_detect_cmp, the code already using initial apic
> to get node id, why adding some extra code double check the node id?

Because it is not necessarily matching.

>
> Also
> apicid = phys_proc_id[cpu]; <----- initial apic id
>
> and then apicid_to_node[apicid]....
>
> that is wrong if the cpu apic id is lifted.

Can you describe exactly what you think is wrong? 

-Andi
