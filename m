Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbTJ0Ju3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 04:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbTJ0Jt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 04:49:57 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:55194 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S261193AbTJ0Js5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 04:48:57 -0500
Date: Mon, 27 Oct 2003 10:48:55 +0100 (MET)
Message-Id: <200310270948.h9R9mtl5003515@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: alan@lxorguk.ukuu.org.uk
Subject: Re: [RFC] must fix lists
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Oct 2003 22:11:35 +0100, Alan Cox wrote:
>On Mer, 2003-10-22 at 03:50, Albert Cahalan wrote:
>> The system in question would also lose time when
>> under heavy load. Note that HZ is now 1000 HZ.
>> If interrupts are kept off for too long or an
>> SMI grabs the CPU...
>
>With a lot of laptops this is a huge problem. Its one of the reasons Red
>Hat went back to 100Hz in the RH 2.4 tree. With many laptops your clock
>becomes junk at 1Khz. It will be interesting to see if the ACPI timers
>help but that wont solve things for older laptops.

Or for really old desktops. My 486 loses time at a rate of about
2 minutes per hour when running 2.5/2.6 and doing lots of disk I/O.
Changing HZ back to 100 solves that problem.

I think we need a CONFIG_HZ.

/Mikael
