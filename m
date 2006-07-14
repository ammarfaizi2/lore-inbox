Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161279AbWGNGWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161279AbWGNGWk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 02:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161280AbWGNGWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 02:22:40 -0400
Received: from terminus.zytor.com ([192.83.249.54]:15279 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1161279AbWGNGWj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 02:22:39 -0400
Message-ID: <44B73827.9070108@zytor.com>
Date: Thu, 13 Jul 2006 23:22:31 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Linus Torvalds <torvalds@osdl.org>, Edgar Hucek <hostmaster@ed-soft.at>,
       LKML <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [PATCH 1/1] Fix boot on efi 32 bit Machines [try #4]
References: <44A04F5F.8030405@ed-soft.at>	<Pine.LNX.4.64.0606261430430.3927@g5.osdl.org>	<44A0CCEA.7030309@ed-soft.at>	<Pine.LNX.4.64.0606262318341.3927@g5.osdl.org>	<44A304C1.2050304@zytor.com>	<m1ac7r9a9n.fsf@ebiederm.dsl.xmission.com>	<44A8058D.3030905@zytor.com>	<m11wt3983j.fsf@ebiederm.dsl.xmission.com>	<44AB8878.7010203@ed-soft.at>	<m1lkr83v73.fsf@ebiederm.dsl.xmission.com>	<44B6BF2F.6030401@ed-soft.at>	<Pine.LNX.4.64.0607131507220.5623@g5.osdl.org> <m1lkqwyfv0.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1lkqwyfv0.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> 
> While we are thinking about this I have a stupid question.
> Currently if a memory mapped region does not fall in a standard PCI
> bar we insist it must be E820 reserved.  However if we E820 reserve
> the memory of a standard pci bar it becomes unusable.
> 
> Is this really the behavior that we intend?
> 
> It gets confusing that E820 reserved gets double duty as memory
> the BIOS is using and MMIO space that is mapped by a non-standard bar.
> 

Well, they are both really the same thing... "memory space the OS has no 
idea how it works; here there be dragons."

	-hpa

