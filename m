Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbUDOIqc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 04:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbUDOIqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 04:46:21 -0400
Received: from mail3.codesense.com ([213.132.104.154]:40605 "EHLO
	mail3.codesense.com") by vger.kernel.org with ESMTP id S261821AbUDOIqT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 04:46:19 -0400
Subject: Re: Failing back to INSANE timesource :) Time stopped today.
From: Niclas Gustafsson <niclas.gustafsson@codesense.com>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Patricia Gaughen <gone@us.ibm.com>
In-Reply-To: <1081967804.4705.105.camel@cog.beaverton.ibm.com>
References: <1081416100.6425.45.camel@gmg.codesense.com>
	 <1081465114.4705.4.camel@cog.beaverton.ibm.com>
	 <1081932857.17234.37.camel@gmg.codesense.com>
	 <1081967804.4705.105.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Message-Id: <1082018775.17234.137.camel@gmg.codesense.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 15 Apr 2004 10:46:16 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ons 2004-04-14 klockan 20.36 skrev john stultz:

> > Where can I see what the system is currently using as a timing source
> > (TSC/HPET/PIT etc.)?
> 
> Note the "Using tsc for high-res timesource" in your dmesg. 
> 
Yes, I noticed that, however, when it stops using tsc, is there a way to
see what the current strategy is?  I.e. to what time source it is
falling back to? Or perhaps this is always the same? And because of this
not implemented into the proc-fs?  I have just briefly looked at the
kernel source for this, I'll have a closer look today if I can find the
time.

> I'm working now to reproduce this w/ a 2G system here in our lab, and
> just for completeness, could you also send me your BIOS revision number?
> 
Sure, Here is some info from bios:

Machine Type:  867373X
Flash EEPROM Revision Level: PLE161AUS
System Board Identifier: NA60B7Y0S3Q
System Serial Number: KDZZ6FC
Bios Date: 09/10/03

Some more info from Advanced/Cpu Frequency:
Bus: 133  MHz
Cpu Multiplier: 18 X
Processor Speed: 2.8 GHz
Single processor MP Table: Enabled
MP Table Version: 1.4
Hyper-Threading technology: ----------


Just a thought, how much if any, increase in performance can one gain
when disabling the Single processor MP Table option? It says, in the
help on that options, that one can benefit from disabling it on a
UP-system if I don't remember wrong now.

 
 
Cheers,

Niclas


