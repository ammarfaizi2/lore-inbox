Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWGFTo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWGFTo5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 15:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWGFTo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 15:44:57 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:15058 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750757AbWGFTo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 15:44:56 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@muc.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Doug Thompson <norsk5@yahoo.com>,
       akpm@osdl.org, mm-commits@vger.kernel.org, norsk5@xmission.com,
       linux-kernel@vger.kernel.org
Subject: Re: + edac-new-opteron-athlon64-memory-controller-driver.patch added to -mm tree
References: <20060705220425.GB83806@muc.de>
	<m1odw32rep.fsf@ebiederm.dsl.xmission.com>
	<20060706130153.GA66955@muc.de>
	<m18xn621i6.fsf@ebiederm.dsl.xmission.com>
	<20060706165159.GB66955@muc.de>
	<m18xn6zkx3.fsf@ebiederm.dsl.xmission.com>
	<20060706180826.GA95795@muc.de>
	<1152210898.13734.12.camel@localhost.localdomain>
	<20060706182729.GA97717@muc.de>
	<m1fyhey2hc.fsf@ebiederm.dsl.xmission.com>
	<20060706191804.GB97717@muc.de>
Date: Thu, 06 Jul 2006 13:43:51 -0600
In-Reply-To: <20060706191804.GB97717@muc.de> (Andi Kleen's message of "6 Jul
	2006 21:18:04 +0200, Thu, 6 Jul 2006 21:18:04 +0200")
Message-ID: <m17j2qy0w8.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> writes:

> On Thu, Jul 06, 2006 at 01:09:35PM -0600, Eric W. Biederman wrote:
>> > Then anything with MMIO or interrupts or anything dynamic 
>> > definitely belongs into kernel space agreed.
>> 
>> Yep we sometimes have to mess with MMIO.
>
> Not on K8 at least, no? 
>
> Maybe we should discuss each chipset separatedly :)
 :)

>> > But at least on K8 DIMM inventory is purely reading PCI config space on
>> > something that doesn't change and doesn't need any locking. 
>> > It also doesn't need to do anything complicated, but just look
>> > for the right PCI ID.
>> 
>> Mostly.  Except for the part where you have to figure out the stepping
>> of the processor connected to the memory controller to properly decode
>> the registers.  AMD should have used the revision field in pci config
>> space but...
>
> That's in /proc/cpuinfo

Some of it.  Taking a quick glance I can't seem to see a nodeid field.
Not that it especially likely you would have a system with mixed revision
cpus (it is a pain in the BIOS) but since it is possible it at least make
sense to try.

Eric

