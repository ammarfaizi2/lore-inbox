Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbTIHHnF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 03:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbTIHHnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 03:43:05 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:10504 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262072AbTIHHnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 03:43:02 -0400
Date: Mon, 8 Sep 2003 08:42:58 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.6] arch/arm/mm/tlb-v4wb.S needs to lose a header
Message-ID: <20030908084258.B1092@flint.arm.linux.org.uk>
Mail-Followup-To: Zwane Mwaikambo <zwane@linuxpower.ca>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53.0309080029200.14426@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.53.0309080029200.14426@montezuma.fsmlabs.com>; from zwane@linuxpower.ca on Mon, Sep 08, 2003 at 12:40:10AM -0400
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08, 2003 at 12:40:10AM -0400, Zwane Mwaikambo wrote:
> Whilst building for an SA1100 i got the following snippets;
> 
>   AS      arch/arm/mm/tlb-v4wb.o
> In file included from include/linux/spinlock.h:13,
>                  from include/linux/capability.h:45,
>                  from include/linux/sched.h:7,
>                  from include/linux/mm.h:4,
>                  from include/asm/tlbflush.h:14,
>                  from arch/arm/mm/tlb-v4wb.S:18:
> include/linux/kernel.h:32: warning: `ALIGN' redefined
> include/linux/linkage.h:24: warning: this is the location of the previous definition
> In file included from include/asm/tlbflush.h:14,
> 
> In file included from include/asm/tlbflush.h:14,
>                  from arch/arm/mm/tlb-v4wb.S:18:
> include/linux/mm.h:87: warning: `VM_EXEC' redefined
> include/asm/constants.h:16: warning: this is the location of the previous 
> definition

This is caused by including linux/mm.h into asm/tlbflush.h, but it does
show that we don't need asm/tlbflush.h included here.

Same change applied to the other tlb-*.S files, thanks.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
