Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbULJAvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbULJAvG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 19:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbULJAvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 19:51:06 -0500
Received: from fmr05.intel.com ([134.134.136.6]:63415 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S261579AbULJAvB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 19:51:01 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Compatibilty patch] sigtimedwait
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date: Fri, 10 Dec 2004 08:49:56 +0800
Message-ID: <894E37DECA393E4D9374E0ACBBE7427013CA00@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Compatibilty patch] sigtimedwait
Thread-Index: AcTdGbThxvrk3+ViTPmQgcG90V/d2QBN1nnw
From: "Zou, Nanhai" <nanhai.zou@intel.com>
To: "Stephen Rothwell" <sfr@canb.auug.org.au>
Cc: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>,
       "Luck, Tony" <tony.luck@intel.com>, <ak@suse.de>, <ralf@linux-mips.org>,
       <paulus@au.ibm.com>, <schwidefsky@de.ibm.com>, <Davem@davemloft.net>
X-OriginalArrivalTime: 10 Dec 2004 00:49:57.0018 (UTC) FILETIME=[2B68A7A0:01C4DE52]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

compat_siginfo_t is a better name.
However the structure siginfo_32t is used in other places in 5 arches
expect ppc64.
I think rename them in this patch will make the patch too big and not so
straightforward.
Maybe we can rename it in another separate patch.

> -----Original Message-----
> From: Stephen Rothwell [mailto:sfr@canb.auug.org.au]
> Sent: Wednesday, December 08, 2004 7:33 PM
> To: Zou, Nanhai
> Cc: linux-kernel@vger.kernel.org; akpm@osdl.org; Luck, Tony;
ak@suse.de;
> ralf@linux-mips.org; paulus@au.ibm.com; schwidefsky@de.ibm.com;
> Davem@davemloft.net
> Subject: Re: [Compatibilty patch] sigtimedwait
> 
> On Wed, 8 Dec 2004 08:48:56 +0800 "Zou, Nanhai" <nanhai.zou@intel.com>
wrote:
> >
> >
> > This patch also merges all 6 32 bit layer sys_rt_sigtimedwait in
IA64,
> > X86_64, PPC64, Sparc64, S390 and MIPS into 1 compat_rt_sigtimedwait.
> 
> I think compat_siginfo_t/struct compat_siginfo should be the preferred
> name for the structure like all the other comptibility types.
> 
> --
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> http://www.canb.auug.org.au/~sfr/
