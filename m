Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263340AbUFKBGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263340AbUFKBGf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 21:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263366AbUFKBGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 21:06:35 -0400
Received: from holomorphy.com ([207.189.100.168]:61837 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263340AbUFKBGe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 21:06:34 -0400
Date: Thu, 10 Jun 2004 18:05:58 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: long <tlnguyen@snoqualmie.dp.intel.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, tom.l.nguyen@intel.com
Subject: Re: [PATCH]Re:2.6.7-rc3-mm1
Message-ID: <20040611010558.GC1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	long <tlnguyen@snoqualmie.dp.intel.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, tom.l.nguyen@intel.com
References: <200406102045.i5AKjDJo017156@snoqualmie.dp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406102045.i5AKjDJo017156@snoqualmie.dp.intel.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed. June 09, 2004 William Lee Irwin III wrote:
>> The MSI writers have a lot to answer for. Could you test this?

On Thu, Jun 10, 2004 at 01:45:13PM -0700, long wrote:
> The MSI patch has existed in the kernel since 2.6.3 and has been
> validated in both UP and SMP environments. It appears another patch 
> (don't know which one) redefined the value of TARGET_CPU, which is 
> used by the function msi_address_init() to configure logical
> target CPU. The redefinition of TARGET_CPU without checking its 
> usage by other kernel code broke the build.
> Your patch fixes the build but breaks the devices using MSI in 
> different architectures supported by the function msi_address_init().
> I have attached a patch that fixes the build and maintains cross
> architecture support for MSI.

I didn't know it was a logical APIC ID that was supposed to go in there.
Well, that ought to fix bugs with MSI and clustered hierarchical DFR too.


-- wli
