Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265580AbUFDE1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265580AbUFDE1l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 00:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265583AbUFDE1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 00:27:40 -0400
Received: from mail010.syd.optusnet.com.au ([211.29.132.56]:12242 "EHLO
	mail010.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265580AbUFDE1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 00:27:37 -0400
From: Stuart Young <cef-lkml@optusnet.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: ACPI related hangup during boot, 2.6.6 worked ok, 2.6.7-rc2 freezes
Date: Fri, 4 Jun 2004 14:28:49 +1000
User-Agent: KMail/1.6.2
Cc: Pozsar Balazs <pozsy@uhulinux.hu>, Len Brown <len.brown@intel.com>
References: <20040603194607.GA26410@unicorn.sch.bme.hu>
In-Reply-To: <20040603194607.GA26410@unicorn.sch.bme.hu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406041428.49811.cef-lkml@optusnet.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jun 2004 05:46, Pozsar Balazs wrote:

> On an Intel D865GRH motherboard kernel 2.6.6 works fine, but 2.6.7-rc2
> (vanilla, -mm1 and -mm2 too) freezes during boot if acpi is enabled.
> (using acpi=off, it boots and works)
>
> I could not gather any useable call trace or other debug information.

I think I've hit this bug as well or possibly something related to it, but 
back in 2.6.7-rc1, however I was not able to recreate the issue. I posted a 
message about this to lkml on the 28/05/04 with the subject of:
 [2.6.7-rc1][BUG][ACPI] os_wait_semaphore: Failed to aquire semaphore (loop)

Attached was my config and some debug output, which included a call trace and 
register dump.

Reason I think it's related to this one is that the problem was a continual 
loop on os_wait_semaphore. I was running with CONFIG_ACPI_DEBUG=y, otherwise 
I doubt I would have noticed why it froze.

Hope this helps.

-- 
 Stuart Young (aka Cef)
 cef-lkml@optusnet.com.au is for LKML and related email only
