Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbVKMEup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbVKMEup (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 23:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbVKMEup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 23:50:45 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:24515 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1751345AbVKMEuo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 23:50:44 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: coywolf@sosdg.org
Cc: akpm@osdl.org, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>, Josh Boyer <jdub@us.ibm.com>
Subject: Re: [patch] mark text section read-only 
In-reply-to: Your message of "Sat, 12 Nov 2005 11:34:55 CDT."
             <20051112163455.GA1425@everest.sosdg.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 13 Nov 2005 15:50:03 +1100
Message-ID: <3066.1131857403@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Nov 2005 11:34:55 -0500, 
Coywolf Qi Hunt <coywolf@sosdg.org> wrote:
>+config DEBUG_ROTEXT
>+	bool "Write protect kernel text"
>+	depends on DEBUG_KERNEL
>+	help
>+	  Mark the kernel text as write-protected in the pagetables,
>+	  in order to catch accidental (and incorrect) writes to kernel text
>+	  area. This option will increase TLB pressure thus impact performance.
>+	  Note this may conflict with kprobes. If in doubt, say "N".

Also conflicts with kdb, kgdb, and any other kernel debugger that uses
software breakpoints.

