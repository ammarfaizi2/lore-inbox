Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUC3UZo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 15:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbUC3UZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 15:25:44 -0500
Received: from smtp.sys.beep.pl ([195.245.198.13]:7179 "EHLO maja.beep.pl")
	by vger.kernel.org with ESMTP id S261169AbUC3UZm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 15:25:42 -0500
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: Len Brown <len.brown@intel.com>
Subject: Re: [ACPI] Re: Linux 2.4.26-rc1 (cmpxchg vs 80386 build)
Date: Tue, 30 Mar 2004 22:25:33 +0200
User-Agent: KMail/1.6.1
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
References: <A6974D8E5F98D511BB910002A50A6647615F6939@hdsmsx402.hd.intel.com> <200403302030.26476.arekm@pld-linux.org> <1080677134.980.166.camel@dhcppc4>
In-Reply-To: <1080677134.980.166.camel@dhcppc4>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200403302225.33966.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia Tuesday 30 of March 2004 22:05, Len Brown napisa³:
> I can make sure that ACPI checks implicitly or explicitly
> that CMPXCHG is available -- but I can't make sure that
> some other random part of the kernel which may not have
> been written yet does.  So I'd rather that they not build,
> like ACPI didn't.
Well, I asked for this because there is similar case with some DRI drivers in 
kernel. These drivers use cmpxchg and some time ago it was not possible to 
build them for i386 (and of course run on 486+). This AFAIK did not change.

These not yet written parts of kernel do not exist so nothing to worry about 
right now. Anyway there always could be #warning for i386 - easy to catch 
while compiling and would allow to fix that future kernel code then.

> cheers,
> -Len

> > Wouldn't be better to just remove #ifdef CONFIG_X86_CMPXCHG around
> > __cmpxchg() and cmpxchg macro in ./include/asm-i386/system.h so cmpxchg()
> > would be there always even on i386 but leave CONFIG_X86_CMPXCHG macro if
> > anyone want's to check for it in some code. No code duplication and you
> > get what you need.

-- 
Arkadiusz Mi¶kiewicz     CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org, 1024/3DB19BBD, JID: arekm.jabber.org, PLD/Linux
