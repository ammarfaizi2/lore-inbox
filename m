Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264453AbUDTWQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264453AbUDTWQx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 18:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264425AbUDTWPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 18:15:23 -0400
Received: from [202.65.75.150] ([202.65.75.150]:5595 "EHLO
	pythia.bakeyournoodle.com") by vger.kernel.org with ESMTP
	id S264579AbUDTVvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 17:51:03 -0400
From: Tony Breeds <tony@bakeyournoodle.com>
Date: Wed, 21 Apr 2004 05:41:25 +0800
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Max Asbock <masbock@us.ibm.com>
Subject: Re: [PATCH] Kconfig dependancy update for drivers/misc/ibmasm
Message-ID: <20040420214125.GF3445@bakeyournoodle.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Max Asbock <masbock@us.ibm.com>
References: <20040420210110.GD3445@bakeyournoodle.com> <20040420143418.08962d0b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040420143418.08962d0b.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2004 at 02:34:18PM -0700, Andrew Morton wrote:
 
> Seems sane to me, but I'm not sure why this wasn't done originally.  ie, this:
> 
> +#ifdef CONFIG_SERIAL_8250
>  extern void ibmasm_register_uart(struct service_processor *sp);
>  extern void ibmasm_unregister_uart(struct service_processor *sp);
> +#else
> +#define ibmasm_register_uart(sp)	do { } while(0)
> +#define ibmasm_unregister_uart(sp)	do { } while(0)
> +#endif
> 
> becomes unnecessary with your patch.
> 
> Max, any preferences?

If I read this correctly the above patch would mean that ibmasm can be
built regardless of the value of SERIAL_8250 BUT my patch means it can
only be built if SERIAL_8250 is also being built (regardless of state).

Can the device operate correctly without the uart?  If so then my patch
is bogus.

Yours Tony

        linux.conf.au       http://lca2005.linux.org.au/
	Apr 18-23 2005      The Australian Linux Technical Conference!

