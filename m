Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWJEUbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWJEUbg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 16:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932068AbWJEUbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 16:31:36 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:50318 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932065AbWJEUbf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 16:31:35 -0400
Subject: Re: [PATCH] make mach-generic/summit.c compile on UP
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: Jiri Kosina <jikos@jikos.cz>
Cc: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610051913010.12556@twin.jikos.cz>
References: <Pine.LNX.4.64.0610051913010.12556@twin.jikos.cz>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Thu, 05 Oct 2006 13:31:32 -0700
Message-Id: <1160080292.5664.9.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-05 at 19:16 +0200, Jiri Kosina wrote:
> Hi,
> 
> arch/i386/mach-generic/summit.c doesn't compile (neither in current 
> mainline git tree, nor in 2.6.18-mm3) when CONFIG_SMP is not set:
> 
> In file included from arch/i386/mach-generic/summit.c:17:
> include/asm/mach-summit/mach_apic.h: In function 'apicid_to_node':
> include/asm/mach-summit/mach_apic.h:91: error: 'apicid_2_node' undeclared (first use in this function)
> include/asm/mach-summit/mach_apic.h:91: error: (Each undeclared identifier is reported only once
> include/asm/mach-summit/mach_apic.h:91: error: for each function it appears in.)
> Is the patch below correct?

Well I guess it would fix the apicid_2_node build error but I can't
think of a single good reason to be in a config where you would need any
of the summit code in UP.  Perhaps a kconfig or makefile change in the
right spot would be better. 

Can you send along your config file so I can better understand?  I seem
to be able to build i386 UP just fine.  

Thanks, 
  Keith 

