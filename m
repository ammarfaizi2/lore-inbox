Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266623AbUF3LgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266623AbUF3LgZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 07:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266627AbUF3LgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 07:36:25 -0400
Received: from ozlabs.org ([203.10.76.45]:4320 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266623AbUF3LgV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 07:36:21 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16610.36478.725698.303353@cargo.ozlabs.ibm.com>
Date: Wed, 30 Jun 2004 19:57:18 +1000
From: Paul Mackerras <paulus@samba.org>
To: will schmidt <will_schmidt@vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, anton@samba.org
Subject: Re: [PATCH][PPC64] lparcfg seq_file update
In-Reply-To: <40E1F6FC.3030405@vnet.ibm.com>
References: <40E1F6FC.3030405@vnet.ibm.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

will schmidt writes:

> Hi All,
>     This patch includes updates and cleanup for the PPC64 proc/lparcfg 
> interface.
> 	- use seq_file's seq_printf for output
> 	- remove redundant e2a function. (use viopath.c's instead)
> 	- change to Kconfig to allow building as a module.
> 	- export required symbols from LparData.c
> 
> Please apply.   (or make constructive comments, as necessary.. :-)  )

Could you take out the vpurr stuff please?  I know that it is all
inside #ifdef CONFIG_PPC_VPURR, and there is currently no way for that
to be defined, but it would be cleaner without it.

The vpurr stuff in ameslab is a bit problematic at present since it
will interact badly with hotplug cpu, according to Anton.  I think
the vpurr stuff could be done very simply with a couple of lines of
code in timer_interrupt.

Paul.
