Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288787AbSAXSC2>; Thu, 24 Jan 2002 13:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288800AbSAXSCJ>; Thu, 24 Jan 2002 13:02:09 -0500
Received: from mx2.elte.hu ([157.181.151.9]:64713 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288787AbSAXSBu>;
	Thu, 24 Jan 2002 13:01:50 -0500
Date: Thu, 24 Jan 2002 20:59:18 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Ingo's O(1) scheduler vs. wait_init_idle
In-Reply-To: <154900000.1011894435@flay>
Message-ID: <Pine.LNX.4.33.0201242058170.5795-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 24 Jan 2002, Martin J. Bligh wrote:

> tecpu 1 has don0 init idl0, do246>c u_idot tai 0idle
> ee doin0000u_idle().
> 00cpu 09  s done idat i0   edoinf cau_00

just take out the TSC initialization messages from smpboot.c, that should
ungarble the output. And/or add this to printk.c:

	if (smp_processor_id())
		return;

this way you'll only see a single CPU's printk messages.

	Ingo

