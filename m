Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262842AbVGHTyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262842AbVGHTyd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 15:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262839AbVGHTyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 15:54:21 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:17215 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S262842AbVGHTyK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 15:54:10 -0400
X-IronPort-AV: i="3.94,182,1118034000"; 
   d="scan'208"; a="263791647:sNHT22160676"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 2.6.12-rc3] modified firmware_class.c to add a new function request_firmware_nowait_nohotplug
Date: Fri, 8 Jul 2005 14:54:07 -0500
Message-ID: <B37DF8F3777DDC4285FA831D366EB9E20730C7@ausx3mps302.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 2.6.12-rc3] modified firmware_class.c to add a new function request_firmware_nowait_nohotplug
Thread-Index: AcWD9A09i95B3i8cRlOE+nJzCIRg+AAAJ8ZQ
From: <Abhay_Salunke@Dell.com>
To: <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
X-OriginalArrivalTime: 08 Jul 2005 19:54:07.0594 (UTC) FILETIME=[CD16BCA0:01C583F6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Also, why not just add the hotplug flag to the firmware structure?
That
request_firmware kmalloc's the firmware structure and frees it when
returned. The only way to indicate request_firmware to skip hotplug was
by passing a hotplug flag on the stack. 
> way you don't have to add another function just to add another flag.
> And you could probably get rid of the nowait version in the same way.
Also thought of leaving request_firmware_nowait intact didn't want to
break others using this function.

Thanks
Abhay
