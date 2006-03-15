Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932582AbWCOFli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582AbWCOFli (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 00:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932596AbWCOFli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 00:41:38 -0500
Received: from proof.pobox.com ([207.106.133.28]:17569 "EHLO proof.pobox.com")
	by vger.kernel.org with ESMTP id S932582AbWCOFlh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 00:41:37 -0500
Date: Tue, 14 Mar 2006 23:44:16 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Ashok Raj <ashok.raj@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, olel@ans.pl, venkatesh.pallipadi@intel.com,
       linux-kernel@vger.kernel.org, suresh.b.siddha@intel.com,
       rajesh.shah@intel.com, ak@muc.de
Subject: Re: More than 8 CPUs detected and CONFIG_X86_PC cannot handle it on 2.6.16-rc6
Message-ID: <20060315054416.GF3205@localhost.localdomain>
References: <20060312032523.109361c1.akpm@osdl.org> <Pine.LNX.4.64.0603121359540.31039@bizon.gios.gov.pl> <20060312073524.A9213@unix-os.sc.intel.com> <Pine.LNX.4.64.0603122206110.19689@bizon.gios.gov.pl> <20060312143053.530ef6c9.akpm@osdl.org> <20060313113615.A24797@unix-os.sc.intel.com> <20060313115155.24dfb6f3.akpm@osdl.org> <20060313120552.A25020@unix-os.sc.intel.com> <20060313142223.7ac20a65.akpm@osdl.org> <20060313150435.A26689@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060313150435.A26689@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok Raj wrote:
> On Mon, Mar 13, 2006 at 02:22:23PM -0800, Andrew Morton wrote:
> > 
> > And does it affect pretend-x86-hotplug, or is it only affecting real hotplug?
> > 
> its no more pretend-x86, in the past we used to put the cpu in idle(), 
> now we do put the cpu in halt and bring back by another startup ipi, just like 
> boot sequence, both for x86 and x86_64.

That's actually broken since 2.6.14 (at least on my P3 box); please
see:

Subject: i386 cpu hotplug bug - instant reboot when onlining secondary

http://lkml.org/lkml/2006/2/19/186


