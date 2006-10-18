Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030267AbWJRNEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbWJRNEs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 09:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030269AbWJRNEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 09:04:48 -0400
Received: from colin.muc.de ([193.149.48.1]:53778 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1030267AbWJRNEr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 09:04:47 -0400
Date: 18 Oct 2006 15:04:45 +0200
Date: Wed, 18 Oct 2006 15:04:45 +0200
From: Andi Kleen <ak@muc.de>
To: "Lu, Yinghai" <yinghai.lu@amd.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       yhlu.kernel@gmail.com
Subject: Re: [PATCH] x86_64: store Socket ID in phys_proc_id
Message-ID: <20061018130445.GA68136@muc.de>
References: <5986589C150B2F49A46483AC44C7BCA412D700@ssvlexmb2.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5986589C150B2F49A46483AC44C7BCA412D700@ssvlexmb2.amd.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2006 at 02:15:38PM -0700, Lu, Yinghai wrote:
> From: Andi Kleen [mailto:ak@muc.de] 
> 
> >> Socket ID is 0 for first Physical processor?
> >It must just be some unique ID for each socket.
> 
> For dual core, if I lift AP's APIC ID and no touch BSP's APIC ID.
> For example, BSP is still 0, and second core is 0x11.
> The phys_proc_id will be 0 for BSP, and 8 for second core.
> So I suggest you to use initial APIC ID to get socket id instead of APIC
> ID.

Hmm, that might make sense yes.

I'm just afraid what I will break again if i touch this -- it took several
iterations to get it to this state which AFAIK works everywhere right now.
And when it breaks it's usually subtle as "system boots, but runs
slower when ACPI is turned off because NUMA nodes are off" 

Can you remind me again what would be fixed by using the initial APIC ID?
Just prettier numbering in your lifted APIC IDs case? Or something
else too?

-Andi

