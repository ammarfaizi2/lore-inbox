Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262662AbUC2Fcf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 00:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbUC2Fcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 00:32:35 -0500
Received: from ns.suse.de ([195.135.220.2]:693 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262662AbUC2Fce (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 00:32:34 -0500
Date: Mon, 29 Mar 2004 02:09:57 +0200
From: Andi Kleen <ak@suse.de>
To: Len Brown <len.brown@intel.com>
Cc: arekm@pld-linux.org, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Re: Linux 2.4.26-rc1 (cmpxchg vs 80386 build)
Message-Id: <20040329020957.43a2ce5a.ak@suse.de>
In-Reply-To: <1080535754.16221.188.camel@dhcppc4>
References: <A6974D8E5F98D511BB910002A50A6647615F6939@hdsmsx402.hd.intel.com>
	<1080535754.16221.188.camel@dhcppc4>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Mar 2004 23:49:15 -0500
Len Brown <len.brown@intel.com> wrote:

> 
> I'm open to suggestions on the right way to fix this.
> 
> 1. recommend CONFIG_ACPI=n for 80386 build.
> 
> 2. force CONFIG_ACPI=n for 80386 build.
> 
> 3. invoke cmpxchg from acpi even for 80386 build.


I think (3) is best. Just define it always, even when the kernel is built for
i386. I considered it always a bug that cmpxchg was not defined in i386 builds. 
The users of it just have to ensure it won't actually run on an i386 (by cpuid 
or implicitely like ACPI does) 

-Andi
