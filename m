Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbWGRVAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbWGRVAH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 17:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWGRVAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 17:00:07 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:51584 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932401AbWGRVAD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 17:00:03 -0400
Date: Tue, 18 Jul 2006 14:00:25 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: David Miller <davem@davemloft.net>
Cc: zach@vmware.com, arjan@infradead.org, chrisw@sous-sol.org,
       linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, jeremy@goop.org, ak@suse.de,
       akpm@osdl.org, rusty@rustcorp.com.au, ian.pratt@xensource.com,
       Christian.Limpach@cl.cam.ac.uk
Subject: Re: [RFC PATCH 18/33] Subarch support for CPUID instruction
Message-ID: <20060718210025.GE2654@sequoia.sous-sol.org>
References: <20060718091953.003336000@sous-sol.org> <1153217686.3038.37.camel@laptopd505.fenrus.org> <44BCC720.7050601@vmware.com> <20060718.134625.123974562.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060718.134625.123974562.davem@davemloft.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Miller (davem@davemloft.net) wrote:
> From: Zachary Amsden <zach@vmware.com>
> Date: Tue, 18 Jul 2006 04:33:52 -0700
> 
> > You really need a CPUID hook.  The instruction is non-virtualizable, and 
> > anything claiming to be a hypervisor really has to support masking and 
> > flattening the cpuid namespace for the instruction itself.  It is used 
> > in assembler code and very early in boot.  The alternative is injecting 
> > a bunch of Xen-specific code to filter feature bits into the i386 layer, 
> > which is both bad for Linux and bad for Xen - and was quite ugly in the 
> > last set of Xen patches.
> 
> Userspace will still see the full set of cpuid bits, since
> it can still execute cpuid unimpeded, is this ok?

Yup, it's for the kernel (things like systenter vs int 80 in vdso).

thanks,
-chris
