Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271681AbRHQQAL>; Fri, 17 Aug 2001 12:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271682AbRHQQAC>; Fri, 17 Aug 2001 12:00:02 -0400
Received: from trained-monkey.org ([209.217.122.11]:24842 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP
	id <S271681AbRHQP7u>; Fri, 17 Aug 2001 11:59:50 -0400
From: Jes Sorensen <jes@trained-monkey.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15229.16241.39447.219387@trained-monkey.org>
Date: Fri, 17 Aug 2001 11:59:45 -0400
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ralf Baechle <ralf@uni-koblenz.de>, linux-kernel@vger.kernel.org
Subject: Re: [patch] dz.c 64 bit locking issues
In-Reply-To: <Pine.GSO.3.96.1010817175020.16692A-100000@delta.ds2.pg.gda.pl>
In-Reply-To: <20010817164031.A6083@bacchus.dhis.org>
	<Pine.GSO.3.96.1010817175020.16692A-100000@delta.ds2.pg.gda.pl>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Maciej" == Maciej W Rozycki <macro@ds2.pg.gda.pl> writes:

Maciej> On Fri, 17 Aug 2001, Ralf Baechle wrote:
>> > The dz.c driver has an instance where it does save_flags() to a 32
>> bit > type which isn't safe for 64 bit boxen.
>> 
>> It's safe because a MIPS only driver.

Maciej>  Not necessarily.  It might be safe now, but there is a
Maciej> TURBOchannel serial card with DZ11-compatible chipset that could
Maciej> be driven by the dz.c code after a few tweaks.  And chances are
Maciej> someone will finish writing support for TURBOchannel Alphas one
Maciej> day...

Maciej>  The change is harmless anyway.

Yep, I also think it's better for cosmetic reasons that we make all
drivers use unsigned long. That way the chance of someone else copying
bad code for a new driver is less likely.

Jes
