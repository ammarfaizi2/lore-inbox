Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267431AbUIUAwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267431AbUIUAwN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 20:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267429AbUIUAwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 20:52:13 -0400
Received: from mailhub.hp.com ([192.151.27.10]:51632 "EHLO mailhub.hp.com")
	by vger.kernel.org with ESMTP id S267414AbUIUAwI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 20:52:08 -0400
Subject: Re: [ACPI] PATCH-ACPI based CPU hotplug[2/6]-ACPI Eject interface
	support
From: Alex Williamson <alex.williamson@hp.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: acpi-devel@lists.sourceforge.net,
       Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>,
       "Brown, Len" <len.brown@intel.com>,
       LHNS list <lhns-devel@lists.sourceforge.net>,
       Linux IA64 <linux-ia64@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200409201812.45933.dtor_core@ameritech.net>
References: <20040920092520.A14208@unix-os.sc.intel.com>
	 <200409201333.42857.dtor_core@ameritech.net>
	 <20040920122404.B15677@unix-os.sc.intel.com>
	 <200409201812.45933.dtor_core@ameritech.net>
Content-Type: text/plain
Date: Mon, 20 Sep 2004 18:52:05 -0600
Message-Id: <1095727925.8780.58.camel@mythbox>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-20 at 18:12 -0500, Dmitry Torokhov wrote: 
> 
> Hi Anil,
> 
> I obviously failed to deliver my idea :) I meant that I would like add eject
> attribute (along with maybe status, hid and some others) to kobjects in
> /sys/firmware/acpi tree.
> 

Dmitry,

   See the patch I just posted to acpi-devel and lkml (Subject:
[PATCH/RFC] exposing ACPI objects in sysfs).  It exposes acpi objects as
you describe.   Something simple like:

 # cat /sys/firmware/acpi/namespace/ACPI/_SB/LSB0/_EJ0

Will call the _EJ0 method on the ACPI device.  You can evaluate eject
dependencies using the _EJD method.

	Alex



