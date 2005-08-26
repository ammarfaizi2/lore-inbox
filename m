Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751513AbVHZFFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbVHZFFs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 01:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbVHZFFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 01:05:47 -0400
Received: from math.ut.ee ([193.40.36.2]:58520 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S1751511AbVHZFFr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 01:05:47 -0400
Date: Fri, 26 Aug 2005 08:05:29 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Masoud Sharbiani <masouds@masoud.ir>, Len Brown <len.brown@intel.com>
Subject: Re: 2.6.13-rc6: halt instead of reboot
In-Reply-To: <m11x4iofmw.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.SOC.4.61.0508260802230.22690@math.ut.ee>
References: <Pine.SOC.4.61.0508202137170.13442@math.ut.ee>
 <m14q9iva4q.fsf@ebiederm.dsl.xmission.com> <Pine.SOC.4.61.0508221152350.17731@math.ut.ee>
 <m1mznativw.fsf@ebiederm.dsl.xmission.com> <Pine.SOC.4.61.0508242252120.20856@math.ut.ee>
 <m11x4iofmw.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When skimming through the code I thought that reboot_thru_bios was the
> default.

My bad. I retested it and it's reboot=w was the one that works.

> If you can't track this down we can at least dig up your board DMI ID
> and put it in the list of systems that need to go through the BIOS to reboot.

I have good news - it the ACPI merge commit 
5028770a42e7bc4d15791a44c28f0ad539323807 that seems to break reboot. 
Also acpi=off works around it.

So the "poweroff instead reboot" seems to be an ACPI regression :(

-- 
Meelis Roos (mroos@linux.ee)
