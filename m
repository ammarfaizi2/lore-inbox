Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318930AbSHANjp>; Thu, 1 Aug 2002 09:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318931AbSHANjp>; Thu, 1 Aug 2002 09:39:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47116 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318930AbSHANjp>;
	Thu, 1 Aug 2002 09:39:45 -0400
Date: Thu, 1 Aug 2002 14:43:12 +0100
From: Matthew Wilcox <willy@debian.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Grover <andrew.grover@intel.com>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] ACPI: compilation fixes
Message-ID: <20020801144312.A24803@parcelfarce.linux.theplanet.co.uk>
References: <20020801104053.GA137@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020801104053.GA137@elf.ucw.cz>; from pavel@ucw.cz on Thu, Aug 01, 2002 at 12:40:53PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2002 at 12:40:53PM +0200, Pavel Machek wrote:
> -	save_flags(flags);
> +	local_irq_save(flags);
> +	local_irq_disable();

umm.  local_irq_save disables interrupts:

#define local_irq_save(x)       __asm__ __volatile__("pushfl ; popl %0 ; cli":"=
g" (x): /* no input */ :"memory")

i think you're confused with local_save_flags.

-- 
Revolutions do not require corporate support.
