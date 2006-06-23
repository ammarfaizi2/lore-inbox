Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932918AbWFWHr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932918AbWFWHr0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 03:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932923AbWFWHr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 03:47:26 -0400
Received: from mga07.intel.com ([143.182.124.22]:19474 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S932918AbWFWHrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 03:47:25 -0400
X-IronPort-AV: i="4.06,168,1149490800"; 
   d="scan'208"; a="56363140:sNHT70843773"
Date: Fri, 23 Jun 2006 00:41:42 -0700
From: Rajesh Shah <rajesh.shah@intel.com>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Rajesh Shah <rajesh.shah@intel.com>, Andi Kleen <ak@suse.de>,
       Brice Goglin <brice@myri.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] PCI extended conf space when MMCONFIG disabled because of e820
Message-ID: <20060623004141.A27049@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <44907A8E.1080308@myri.com> <4491029D.4060002@linux.intel.com> <20060621151942.A17228@unix-os.sc.intel.com> <200606220032.19388.ak@suse.de> <20060621171536.A17560@unix-os.sc.intel.com> <449A629F.9000401@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <449A629F.9000401@linux.intel.com>; from arjan@linux.intel.com on Thu, Jun 22, 2006 at 11:27:59AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 11:27:59AM +0200, Arjan van de Ven wrote:
> Rajesh Shah wrote:
> > Oh I agree with you that booting is more important. My point with
> > the spec statement was that most BIOS developers may not even know
> > they are doing something "wrong" by not listing these resources in
> > the int15 E820 table, since the document they normally refer to
> > doesn't say so. I suspect there are many more systems out there
> > which do the same thing and will fail the check, but we never notice
> > since most users don't try to ever access the extended space today.
> 
> well... it's sort of common sense though.. if you want non-ACPI OSes to 
> work properly (like the older 2.4 based distros...)
> 
In this case we already have an ACPI dependence, since the MCFG
table is listed in ACPI. In any case, I have a patch that got me
my extended config space back on the one machine I've tested so
far. I'll test it out on the remaining 2 where I saw this problem
and send it out.

Rajesh
