Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271939AbTG2SQN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 14:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271964AbTG2SQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 14:16:13 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:15859 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S271939AbTG2SQH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 14:16:07 -0400
Subject: Re: [REPOST] "apm: suspend: Unable to enter requested state" after
	2.5.31 (incl. 2.6.0testX)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Charles Lepple <clepple@ghz.cc>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <32460.216.12.38.216.1059494755.squirrel@www.ghz.cc>
References: <28705.216.12.38.216.1059490232.squirrel@www.ghz.cc>
	 <1059491223.6094.6.camel@dhcp22.swansea.linux.org.uk>
	 <32460.216.12.38.216.1059494755.squirrel@www.ghz.cc>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059502242.5987.24.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 Jul 2003 19:10:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-07-29 at 17:05, Charles Lepple wrote:
> > 0x00109300, 0x00409200 ?
> 
> Is this what you're referring to?

Yes

> -static struct desc_struct      bad_bios_desc = { 0, 0x00409200 };
> +static struct desc_struct      bad_bios_desc = { 0x00109300, 0x00409200 };
>  static char                    driver_version[] = "1.16ac";    /* no
> spaces */
> 
> I tried this on top of 2.6.0-test2, and it didn't work. Where does the
> first number in that initializer come from?

I wasnt sure if the kernel code was initialising all the flag and control bits
of the segment entry. That should have set the bits required anyway just in
case if I got it right (Pentium pro dev manual vol III chapter 7)

It might be 0x00009300, it might be set already, or it might be some other
effect thats breaking your laptop of course


