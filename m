Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270978AbTHKEdJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 00:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270982AbTHKEdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 00:33:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:17058 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270978AbTHKEdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 00:33:07 -0400
Message-ID: <34253.4.4.25.4.1060576385.squirrel@www.osdl.org>
Date: Sun, 10 Aug 2003 21:33:05 -0700 (PDT)
Subject: Re: /proc/stat's intr field looks odd, although /proc/interrupts seems correct
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <rml@ufl.edu>
In-Reply-To: <1060574873.684.41.camel@localhost>
References: <1060572792.1113.10.camel@boobies.awol.org>
        <34161.4.4.25.4.1060573727.squirrel@www.osdl.org>
        <1060574873.684.41.camel@localhost>
X-Priority: 3
Importance: Normal
Cc: <cmrivera@ufl.edu>, <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, 2003-08-10 at 20:48, Randy.Dunlap wrote:
>
>> Yes, for most architectures, it prints interrupts from 0 thru NR_IRQS:
>> 	for (i = 0 ; i < NR_IRQS ; i++)
>> 		len += sprintf(page + len, " %u", kstat_irqs(i));
>> and NR_IRQS varies depending on the kernel build options, but (for x86) is
>> usually either 16 or 224.
>
> Eww. So I guess on SMP, it is 224.

Yes.

> Might be nice to only print lines that are registered, like
> /proc/interrupts. But then you have no way of knowing which field is which
> interrupt line.  Ugh.
>
> How can we expect anything to parse that line?

Ugh-ly?  We can move it to sysfs and then change the file format
to intnum:count pairs (e.g.).

~Randy



