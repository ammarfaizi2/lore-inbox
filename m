Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbVKWRgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbVKWRgi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 12:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbVKWRgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 12:36:38 -0500
Received: from ns1.suse.de ([195.135.220.2]:25061 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751139AbVKWRgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 12:36:37 -0500
Date: Wed, 23 Nov 2005 18:36:36 +0100
From: Andi Kleen <ak@suse.de>
To: yhlu <yinghailu@gmail.com>
Cc: Ronald G Minnich <rminnich@lanl.gov>, Andi Kleen <ak@suse.de>,
       discuss@x86-64.org, linuxbios@openbios.org,
       yhlu <yhlu.kernel@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [LinuxBIOS] x86_64: apic id lift patch
Message-ID: <20051123173636.GL20775@brahms.suse.de>
References: <86802c440511211349t6a0a9d30i60e15fa23b86c49d@mail.gmail.com> <20051121220605.GD20775@brahms.suse.de> <43849FA5.4020201@lanl.gov> <2ea3fae10511230919l4d9829d8j3ce5d820b74074d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ea3fae10511230919l4d9829d8j3ce5d820b74074d1@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 09:19:59AM -0800, yhlu wrote:
> sth about SRAT in LinuxBIOS,  I have put SRAT dynamically support in
> LinuxBIOS, but the whole acpi support still need dsdt, current we only have
> dsdt for AMD chipset in LB. And we can not have the access the dsdt asl from
> Nvidia chipset yet...

You probably don't need most of it. Just a basic SRAT table (no AML methods)
and enough to keep the ACPI interpreter from aborting early.

Or alternatively just fix the bug that caused you to go with discontig
APICs in the first place.

-Andi
