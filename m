Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267791AbTBKMZG>; Tue, 11 Feb 2003 07:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267794AbTBKMZG>; Tue, 11 Feb 2003 07:25:06 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:63750 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267791AbTBKMZF>; Tue, 11 Feb 2003 07:25:05 -0500
Date: Tue, 11 Feb 2003 12:34:38 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: Re: Clarify comment in kernel/acpi.c
Message-ID: <20030211123438.B18184@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
	kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
References: <20030210163623.GA1106@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030210163623.GA1106@elf.ucw.cz>; from pavel@ucw.cz on Mon, Feb 10, 2003 at 05:36:23PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 05:36:23PM +0100, Pavel Machek wrote:
> This is more explicit about which low memory means... Please apply,
> 
> --- clean/arch/i386/kernel/acpi.c	2003-01-17 23:13:33.000000000 +0100
> +++ linux-swsusp/arch/i386/kernel/acpi.c	2003-01-27 17:23:36.000000000 +0100
> @@ -507,7 +501,7 @@
>  /**
>   * acpi_reserve_bootmem - do _very_ early ACPI initialisation
>   *
> - * We allocate a page in low memory for the wakeup
> + * We allocate a page in 1MB low memory for the wakeup

Unfortunately this doesn't clarify it.  I think you mean:

"We allocate a page from the first 1MB of memory for the wakeup" ?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

