Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267553AbUI1GI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267553AbUI1GI4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 02:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267555AbUI1GI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 02:08:56 -0400
Received: from fmr12.intel.com ([134.134.136.15]:9377 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S267553AbUI1GIy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 02:08:54 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: suspend/resume support for driver requires an external firmware
Date: Tue, 28 Sep 2004 14:07:42 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8403BD57A2@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: suspend/resume support for driver requires an external firmware
Thread-Index: AcSlHN65Y3tE+Qk0THig+nftOe4sfAABCwtQ
From: "Zhu, Yi" <yi.zhu@intel.com>
To: "Patrick Mochel" <mochel@digitalimplant.org>
Cc: "Dmitry Torokhov" <dtor_core@ameritech.net>,
       <linux-kernel@vger.kernel.org>,
       "Denis Vlasenko" <vda@port.imtp.ilyichevsk.odessa.ua>,
       "Oliver Neukum" <oliver@neukum.org>
X-OriginalArrivalTime: 28 Sep 2004 06:07:43.0243 (UTC) FILETIME=[779BF5B0:01C4A521]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel wrote:
> On Tue, 28 Sep 2004, Zhu, Yi wrote:
>> Agreed. I think now we need a clean interface that makes drivers,
>> swsusp or even the end user to work together to finally achieve the
>> goal.
> 
> Well, if you can read firmware back from the device, then
> that interface is called kmalloc() to allocate the buffer,
> and whatever driver-specific routine to copy it from the
> device into that buffer. It then stays in memory during
> suspend and can be rewritten to the device once resumed.
> 
> What's so bad about that?

Hi Patrick,

Do you still think the ->save_state, ->restore_state are the right
approach
or you want the user to provide the firmware to driver before suspend?

Thanks,
-yi
