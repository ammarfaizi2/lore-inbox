Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270869AbTHKEID (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 00:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270882AbTHKEID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 00:08:03 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:39408 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S270869AbTHKEIC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 00:08:02 -0400
Subject: Re: /proc/stat's intr field looks odd, although /proc/interrupts
	seems correct
From: Robert Love <rml@ufl.edu>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: cmrivera@ufl.edu, linux-kernel@vger.kernel.org
In-Reply-To: <34161.4.4.25.4.1060573727.squirrel@www.osdl.org>
References: <1060572792.1113.10.camel@boobies.awol.org>
	 <34161.4.4.25.4.1060573727.squirrel@www.osdl.org>
Content-Type: text/plain
Message-Id: <1060574873.684.41.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-3) 
Date: Sun, 10 Aug 2003 21:07:53 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-08-10 at 20:48, Randy.Dunlap wrote:

> Yes, for most architectures, it prints interrupts from 0 thru NR_IRQS:
> 	for (i = 0 ; i < NR_IRQS ; i++)
> 		len += sprintf(page + len, " %u", kstat_irqs(i));
> and NR_IRQS varies depending on the kernel build options, but (for x86)
> is usually either 16 or 224.

Eww. So I guess on SMP, it is 224.

Might be nice to only print lines that are registered, like
/proc/interrupts. But then you have no way of knowing which field is
which interrupt line.  Ugh.

How can we expect anything to parse that line?

	Robert Love


