Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263467AbTJ0TKJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 14:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263478AbTJ0TKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 14:10:09 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:7165 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263467AbTJ0TKF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 14:10:05 -0500
Subject: Re: ACPI PM-Timer [Was: Re: [RFC][PATCH] must fix lists]
From: john stultz <johnstul@us.ibm.com>
To: Dominik Brodowski <linux@brodo.de>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, albert@users.sourceforge.net
In-Reply-To: <20031027184908.GA4240@brodo.de>
References: <3F94C833.8040204@cyberone.com.au>
	 <1066943359.6102.14.camel@dhcp23.swansea.linux.org.uk>
	 <20031023172323.A10588@osdlab.pdx.osdl.net>
	 <1067113087.10272.4.camel@dhcp23.swansea.linux.org.uk>
	 <3F9D1557.4050404@cyberone.com.au> <20031027182416.GA3905@brodo.de>
	 <1067280154.1113.334.camel@cog.beaverton.ibm.com>
	 <20031027184908.GA4240@brodo.de>
Content-Type: text/plain
Organization: 
Message-Id: <1067281639.1122.358.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 27 Oct 2003 11:07:19 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-10-27 at 10:49, Dominik Brodowski wrote:
> On Mon, Oct 27, 2003 at 10:42:34AM -0800, john stultz wrote:
> > My only comment is that rather then replacing the time source midstream,
> > could we not do as the HPET time source does and use the late_time_init
> > callback? That avoids the nasty time source switching code. 
> 
> Because "late_time_init" is way too early. It might be usable for the
> (unimplemented) detection method c) -- parsing the ACPI FADT ourselves --
> described in the timer_pm.c code.
> However, the currently used method uses struct acpi_fadt which is
> filled in drivers/acpi/bus.c:acpi_bus_init(), which is called from 
> a subsys_initcall.


Ah, OK. Well, I'd prefer the manual ACPI parsing personally, but having
tried and failed to implement it once myself, I'd more prefer not to do
it myself. ;)

Let me get your patches up and running and I'll see if I have any
reasonable feedback. 

Thanks again!
-john


