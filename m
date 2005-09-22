Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751456AbVIVI5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbVIVI5G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 04:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbVIVI5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 04:57:05 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:42205 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751456AbVIVI5E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 04:57:04 -0400
Date: Thu, 22 Sep 2005 10:57:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Zachary Amsden <zach@vmware.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeffrey Sheldon <jeffshel@vmware.com>,
       Ole Agesen <agesen@vmware.com>, Shai Fultheim <shai@scalex86.org>,
       Andrew Morton <akpm@odsl.org>, Jack Lo <jlo@vmware.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Chris Wright <chrisw@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Andi Kleen <ak@muc.de>
Subject: Re: [PATCH 1/3] Bogus tls from gdt
Message-ID: <20050922085737.GA25909@elte.hu>
References: <200509220737.j8M7bKgh000928@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509220737.j8M7bKgh000928@zach-dev.vmware.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Zachary Amsden <zach@vmware.com> wrote:

> The per-CPU initialization code is copying in bogus data into 
> thread->tls_array.  Note that it copies &per_cpu(cpu_gdt_table, cpu), 
> not &per_cpu(cpu_gdt_table, cpu)[GDT_ENTRY_TLS_MIN).  That is totally 
> broken and unnecessary.  Make the initialization explicitly NULL.
> 
> Signed-off-by: Zachary Amsden <zach@vmware.com>

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
