Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267882AbUHEVcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267882AbUHEVcq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 17:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267968AbUHEVbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 17:31:36 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:28883 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S267964AbUHEVaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 17:30:05 -0400
To: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
Cc: "Grant Grundler" <iod00d@hp.com>, "Randy.Dunlap" <rddunlap@osdl.org>,
       fastboot@osdl.org, linux-ia64@vger.kernel.org,
       Jesse Barnes <jbarnes@engr.sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Re: [BROKEN PATCH] kexec for ia64
References: <D36CE1FCEFD3524B81CA12C6FE5BCAB00750E615@fmsmsx406.amr.corp.intel.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 05 Aug 2004 15:29:09 -0600
In-Reply-To: <D36CE1FCEFD3524B81CA12C6FE5BCAB00750E615@fmsmsx406.amr.corp.intel.com>
Message-ID: <m18yct2s0q.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Tolentino, Matthew E" <matthew.e.tolentino@intel.com> writes:

> >On Wed, Aug 04, 2004 at 08:14:55PM -0600, Eric W. Biederman wrote:
> >> VGA/serial console devices rarely need to do be bus masters so they
> >> should be fine.
> >
> >yeah - you are right. I wasn't thinking.
> >Can anyone comment on UGA or other console devices?
> 
> UGA is essentially a PCI device.  It uses the EFI PCI I/O 
> protocol which gets glued to the kernels pci layer...at least in 
> a prototype.  
> 
> I haven't looked at the latest kexec patch.  How is it handling
> the call to EFI's SetVirtualAddressMap()?  Is it part of the config
> associated with kexec to do efi calls in physical mode only so that
> it doesn't have to contend with potential follow-on invocations 
> resultant from "the next" kernel's initialization?

It should be.  So far all I have seen are tentative ia64 kexec patches.

Eric
