Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbTIHHrL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 03:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbTIHHrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 03:47:11 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17416 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262051AbTIHHrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 03:47:09 -0400
Date: Mon, 8 Sep 2003 08:47:06 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.6] arch/arm/mm/tlb-v4wb.S needs to lose a header
Message-ID: <20030908084706.C1092@flint.arm.linux.org.uk>
Mail-Followup-To: Zwane Mwaikambo <zwane@linuxpower.ca>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53.0309080029200.14426@montezuma.fsmlabs.com> <20030908084258.B1092@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030908084258.B1092@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Mon, Sep 08, 2003 at 08:42:58AM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08, 2003 at 08:42:58AM +0100, Russell King wrote:
> > In file included from include/asm/tlbflush.h:14,
> >                  from arch/arm/mm/tlb-v4wb.S:18:
> > include/linux/mm.h:87: warning: `VM_EXEC' redefined
> > include/asm/constants.h:16: warning: this is the location of the previous 
> > definition
> 
> This is caused by including linux/mm.h into asm/tlbflush.h, but it does
> show that we don't need asm/tlbflush.h included here.

Sorry, you do need asm/tlbflush.h here - we use the various tlb flag
definitions from there in the assembly files to avoid duplicating them.
The solution is not to include linux/mm.h in the first place.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
