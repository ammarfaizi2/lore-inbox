Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbWJQRxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbWJQRxL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 13:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWJQRxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 13:53:11 -0400
Received: from colin.muc.de ([193.149.48.1]:51726 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1750833AbWJQRxK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 13:53:10 -0400
Date: 17 Oct 2006 19:53:08 +0200
Date: Tue, 17 Oct 2006 19:53:08 +0200
From: Andi Kleen <ak@muc.de>
To: Yinghai Lu <yinghai.lu@amd.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       yhlu.kernel@gmail.com
Subject: Re: [PATCH] x86_64: store Socket ID in phys_proc_id
Message-ID: <20061017175308.GB15429@muc.de>
References: <5986589C150B2F49A46483AC44C7BCA412D6E3@ssvlexmb2.amd.com> <86802c440610170834q5921908u5bcd7c2cb4b78dd5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86802c440610170834q5921908u5bcd7c2cb4b78dd5@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2006 at 08:34:47AM -0700, Yinghai Lu wrote:
> Current code store phys_proc_id with init APIC ID, and later will change
> to apicid>>bits.
> 
> So for the apic id lifted system, for example BSP with apicid 0x10, the
> phys_proc_id will be 8.

How is that a problem? 


> This patch use initial APIC ID to get Socket ID.
> 
> It also removed ht_nodeid calculating, because We already have correct
> socket id for sure.

we've had cases where it wasn't identical, that is when i originally
added that code.

-Andi
