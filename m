Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262786AbUBZNaS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 08:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262788AbUBZNaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 08:30:18 -0500
Received: from 75.80-203-232.nextgentel.com ([80.203.232.75]:48848 "EHLO
	lincoln.jordet.nu") by vger.kernel.org with ESMTP id S262786AbUBZNaN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 08:30:13 -0500
Subject: Re: [RFC] ACPI power-off on P4 HT
From: Stian Jordet <liste@jordet.nu>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
In-Reply-To: <20040226130724.GA3704@alpha.home.local>
References: <1076145024.8687.32.camel@dhcppc4>
	 <20040208082059.GD29363@alpha.home.local>
	 <20040208090854.GE29363@alpha.home.local>
	 <20040214081726.GH29363@alpha.home.local>
	 <1076824106.25344.78.camel@dhcppc4>
	 <20040225070019.GA30971@alpha.home.local>
	 <1077695701.5911.130.camel@dhcppc4> <20040226075609.GA745@uberboxen>
	 <20040226105744.GA3406@alpha.home.local>
	 <1077798440.955.1.camel@chevrolet.hybel>
	 <20040226130724.GA3704@alpha.home.local>
Content-Type: text/plain
Message-Id: <1077802199.1503.5.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 26 Feb 2004 14:29:59 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tor, 26.02.2004 kl. 14.07 skrev Willy Tarreau:
> On Thu, Feb 26, 2004 at 01:28:49PM +0100, Stian Jordet wrote:
> > Hi Willy,
> > 
> > Do you have a similar patch for 2.6?
> 
> No, but since Marcelo recently told me that acpi_power_off() was the same in
> 2.4 and 2.6, I think it should apply without much difficulties. A dirty gpm
> cut-n-paste in vi should be enough ;-)

Well, I cut-n-paste it into drivers/acpi/sleep/poweroff.c (which must
have been the place it fits in 2.6). Get this compile failures:

drivers/acpi/sleep/poweroff.c: In function `acpi_power_off':
drivers/acpi/sleep/poweroff.c:30: warning: implicit declaration of
function `apicid_to_phys_cpu_present'
drivers/acpi/sleep/poweroff.c:30: error: invalid operands to binary &
drivers/acpi/sleep/poweroff.c:69: warning: implicit declaration of
function `disable_IO_APIC'
make[3]: *** [drivers/acpi/sleep/poweroff.o] Error 1
make[2]: *** [drivers/acpi/sleep] Error 2
make[1]: *** [drivers/acpi] Error 2
make: *** [drivers] Error 2

But I'm sure a patch like yours for 2.6 would have fixed my, since using
a non-smp kernel works everytime :) Anyway, thanks for your efforts,
hope someone will get this fixed soon :)

Best regards,
Stian

