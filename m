Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030469AbWBHCsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030469AbWBHCsj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 21:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030467AbWBHCsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 21:48:39 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:25806 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965183AbWBHCsi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 21:48:38 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@sgi.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: "'Adrian Bunk'" <bunk@stusta.de>, "Luck, Tony" <tony.luck@intel.com>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let IA64_GENERIC select more stuff 
In-reply-to: Your message of "Tue, 07 Feb 2006 17:40:13 -0800."
             <200602080140.k181eDg20764@unix-os.sc.intel.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 08 Feb 2006 13:48:10 +1100
Message-ID: <10378.1139366890@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Chen, Kenneth W" (on Tue, 7 Feb 2006 17:40:13 -0800) wrote:
>Adrian Bunk wrote on Tuesday, February 07, 2006 5:20 PM
>> You could ask the same question for NUMA:
>> Select generic system type does not mean NUMA systems are only choice I 
>> can have. What's wrong with having an option that works just fine?
>
>Please read more ia64 arch specific code ...
>
>CONFIG_IA64_GENERIC is a platform type choice, you can have platform
>type of DIG, HPZX1, SGI SN2, or all of the above.  DIG platform depends
>on ACPI, thus need ACPI on.  SGI altix is a numa box, thus, need NUMA
>on.  NEC, Fujitsu build numa machines with ACPI SRAT table, thus, need
>ACPI_NUMA on.  When you build a kernel to boot on all platforms, you
>have no choice but to turn on all of the above.  Processor type and SMP
>is different from platform type.  It does not have any dependency on
>platform type.  They are orthogonal choice.
>
>
>> Keith said IA64_GENERIC should select all the options required in
>> order to run on all the IA64 platforms out there.
>                          ^^^^^^^^^^^^^^
>> This is what my patch does.
>
>You patch does more than what you described and is wrong.  Selecting
>platform type should not be tied into selecting SMP nor should it tied
>with processor type, nor should it tied with ARCH_FLATMEM_ENABLE.  All
>of them are orthogonal and independent.

Blame me for the SMP bit.  I have a dim, distant memory that Intel
required all IA64 boxes to be SMP, but I could be wrong.  Also it is
almost pointless to do a generic build which pulls in NUMA etc.,
without also including SMP.

