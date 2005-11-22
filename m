Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbVKVI4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbVKVI4U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 03:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbVKVI4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 03:56:20 -0500
Received: from colin.muc.de ([193.149.48.1]:30980 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1751275AbVKVI4T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 03:56:19 -0500
Date: 22 Nov 2005 09:56:12 +0100
Date: Tue, 22 Nov 2005 09:56:12 +0100
From: Andi Kleen <ak@muc.de>
To: Ashok Raj <ashok.raj@intel.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, gregkh@suse.de,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [patch 2/2] Convert bigsmp to use flat physical mode
Message-ID: <20051122085612.GB9723@muc.de>
References: <20051122000204.890352000@araj-sfield-2> <20051121170411.A15347@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051121170411.A15347@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 05:04:11PM -0800, Ashok Raj wrote:
> On Mon, Nov 21, 2005 at 03:39:16PM -0800, Ashok Raj wrote:
> > 
> >    -       if ((num_processors > 8) &&
> >    -           APIC_XAPIC(ver) &&
> >    -           (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL))
> >    +       if (APIC_XAPIC(ver) &&
> >    +               (CPU_HOTPLUG_ENABLED ||
> >    +               ((num_processors > 8) &&
> >    +                                      (boot_cpu_data.x86_vendor    ==
> >    X86_VENDOR_INTEL))))
> >                    def_to_bigsmp = 1;
> 
> Noticed that Andi send one more patch do enable bigsmp for AMD (i386), and the 
> APIC_XAPIC() check was not properly placed to factor this in. This updated
> patch should work for AMD as well, and switch to bigsmp when we have hotplug 
> enabled.

Looks good thanks.

-Andi
