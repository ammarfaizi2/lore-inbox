Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263293AbTEXS7d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 14:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263522AbTEXS7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 14:59:33 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:517 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263293AbTEXS7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 14:59:32 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-smp@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: [RFC] Fix NMI watchdog documentation
Date: Sat, 24 May 2003 21:12:24 +0200
User-Agent: KMail/1.5.1
References: <3ECFC2D6.2020007@gmx.net>
In-Reply-To: <3ECFC2D6.2020007@gmx.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200305242111.07048.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 24 May 2003 21:07, Carl-Daniel Hailfinger wrote:

Hi Carl-Daniel,

> Documentation/nmi_watchdog.txt does not say which CONFIG_XYZ option has
> to be enabled to use the NMI watchdog, but it mentions that IO-APIC is
> somewhat related.
>
> Documentation/Configure.help is equally unclear. The NMI watchdog is
> mentioned as related to CONFIG_SMP, and the help text for
> CONFIG_X86_UP_APIC says: "The local APIC supports [..] the NMI watchdog"
> That does not necessarily mean that NMI is compiled in once local APIC
> support is selected.
>
> Can someone please shed some light on this issue? I'm willing to create
> a patch to fix the docs once I know if the NMI watchdog is compiled in
> alsways or on what it depends.
the nmi_watchdog is always compiled in if you select "CONFIG_X86_LOCAL_APIC"

see "arch/i386/kernel/Makefile"

ciao, Marc


