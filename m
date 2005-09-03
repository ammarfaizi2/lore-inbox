Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161138AbVICF05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161138AbVICF05 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 01:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161139AbVICF05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 01:26:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45975 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161138AbVICF05 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 01:26:57 -0400
Date: Fri, 2 Sep 2005 22:25:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org,
       James.Bottomley@steeleye.com, linux-scsi@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: 2.6.13-mm1: hangs during boot ...
Message-Id: <20050902222507.64e3ee4e.akpm@osdl.org>
In-Reply-To: <43192D89.50504@bigpond.net.au>
References: <F7DC2337C7631D4386A2DF6E8FB22B30047FA061@hdsmsx401.amr.corp.intel.com>
	<43192D89.50504@bigpond.net.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams <pwil3058@bigpond.net.au> wrote:
>
> Brown, Len wrote:
> >>>[  279.662960]  [<c02d5c74>] wait_for_completion+0xa4/0x110
> > 
> > 
> > possibly a missing interrupt?
> > 
> > 
> >>CONFIG_ACPI=y
> > 
> > 
> > any difference if booted with "acpi=off" or "acpi=noirq"?
> 
> Yes.  In both cases, the system appears to boot normally

OK, we can pass this ball over to the ACPI team.

> but I'm unable 
> to login or connect via ssh.  Also there's a "device not ready" message 
> after the scsi initialization which I don't normally see.  I've attached 
> the scsi initialization output.  The PF_NETLINK error messages after the 
> login prompt in this output are created whenever I try to log in or 
> connect via ssh.

Linus hit that too - it's an interaction between PAM and a modified netlink
error code.

Dave, where are we up to with the fix for that?
