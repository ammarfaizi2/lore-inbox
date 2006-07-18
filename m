Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbWGRKEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWGRKEx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 06:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWGRKEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 06:04:53 -0400
Received: from [216.208.38.107] ([216.208.38.107]:34432 "EHLO
	OTTLS.pngxnet.com") by vger.kernel.org with ESMTP id S932158AbWGRKEw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 06:04:52 -0400
Subject: Re: [RFC PATCH 09/33] Add start-of-day setup hooks to subarch
From: Arjan van de Ven <arjan@infradead.org>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Jeremy Fitzhardinge <jeremy@goop.org>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Zachary Amsden <zach@vmware.com>,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Jeremy Fitzhardinge <jeremy@xensource.com>
In-Reply-To: <20060718091950.750213000@sous-sol.org>
References: <20060718091807.467468000@sous-sol.org>
	 <20060718091950.750213000@sous-sol.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 18 Jul 2006 12:03:53 +0200
Message-Id: <1153217033.3038.25.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-18 at 00:00 -0700, Chris Wright wrote:
> plain text document attachment (i386-setup)
> Implement the start-of-day subarchitecture setup hooks for booting on
> Xen. Add subarch macros for determining loader type and initrd
> location.

> diff -r a5848bce3730 arch/i386/kernel/setup.c
> --- a/arch/i386/kernel/setup.c	Thu Jun 22 16:02:54 2006 -0400
> +++ b/arch/i386/kernel/setup.c	Thu Jun 22 20:20:31 2006 -0400
> @@ -458,6 +458,7 @@ static void __init print_memory_map(char
>  	}
>  }
>  
> +#ifndef HAVE_ARCH_E820_SANITIZE
>  /*
>   * Sanitize the BIOS e820 map.
>   *
> @@ -677,6 +678,7 @@ int __init copy_e820_map(struct e820entr
>  	} while (biosmap++,--nr_map);
>  	return 0;
>  }
> +#endif
>  
Hi,

what is this for? Isn't this 1) undocumented and 2) unclear and 3)
ugly ? (I'm pretty sure the HAVE_ARCH_* stuff is highly deprecated for
new things nowadays)

Greetings,
   Arjan van de Ven

