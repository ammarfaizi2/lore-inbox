Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261686AbSKIQbM>; Sat, 9 Nov 2002 11:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261750AbSKIQbM>; Sat, 9 Nov 2002 11:31:12 -0500
Received: from franka.aracnet.com ([216.99.193.44]:28377 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261686AbSKIQbL>; Sat, 9 Nov 2002 11:31:11 -0500
Date: Sat, 09 Nov 2002 08:34:32 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mikael Pettersson <mikpe@csd.uu.se>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       zwane@holomorphy.com, Linus Torvalds <torvalds@transmeta.com>,
       johnstul@us.ibm.com
Subject: Re: [PATCH][2.5] notsc option needs some attention/TLC
Message-ID: <4222918946.1036830871@[10.10.2.3]>
In-Reply-To: <1036847149.20313.2.camel@irongate.swansea.linux.org.uk>
References: <1036847149.20313.2.camel@irongate.swansea.linux.org.uk>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> If we configure for "I have a TSC, period" you add the option
>> to disable it, which nullifies any benefit of the config option
>> in the first place since we can't assume TSC presence any more.
>> If we don't configure for TSC, you force tsc_disable, which means
>> that a generic kernel _can't_ use the TSC.
> 
> 2.4 was modified to printk a message that TSC was not disabled. This
> does confuse people

Having this config option ass-backwards is mind-bogglingly confusing,
and there seems no real reason for it. John had a plan to just put 
in CONFIG_X86_PIT instead as the inverse of this, and delete 
CONFIG_X86_TSC. He seems to have gone off this idea for some reason
I can't understand ... I think it solves a lot of these issues ...

Having a config option called TSC that in fact has nothing to directly
do with the TSC, but disables the PIT seems silly. The first time I
read all this code I spend quite a while thinking it was all the 
incorrect, and the wrong way around ... things should be more intuitive
than that.

M.
