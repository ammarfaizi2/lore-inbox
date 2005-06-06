Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbVFFUFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbVFFUFN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 16:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbVFFUDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 16:03:55 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:41342 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S261665AbVFFUBD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 16:01:03 -0400
X-IronPort-AV: i="3.93,174,1115010000"; 
   d="scan'208"; a="269705859:sNHT59715500"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new DellBIOS update driver
Date: Mon, 6 Jun 2005 15:01:04 -0500
Message-ID: <367215741E167A4CA813C8F12CE0143B3ED3AD@ausx2kmpc115.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new DellBIOS update driver
Thread-Index: AcVqzSCVuB1Uaa09Rx6lq3YNiDMRGgAANvPg
From: <Abhay_Salunke@Dell.com>
To: <greg@kroah.com>
Cc: <marcel@holtmann.org>, <linux-kernel@vger.kernel.org>, <akpm@osdl.org>,
       <Matt_Domsch@Dell.com>
X-OriginalArrivalTime: 06 Jun 2005 20:00:53.0659 (UTC) FILETIME=[71E756B0:01C56AD2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok, in re-reading the firmware code, you are correct, it will still
> timeout in 10 seconds and call your callback.
> 
> Which, in my opinion, is wrong.  We should have some way to say "wait
> forever".  Care to change the firmware_class.c code to support this?
Will give it a try. So far the request_firmware code calls
kobject_hotplug with action as KOBJ_ADD. It invokes a hotplug script
form user mode. I guess we need to have some reverse mechanism which is
invoked when a user writes to the file.
> 
> I was assuming that this would wait forever, and is why I pointed you
in
> this direction.  Sorry about the confusion here.
> 
I guess the earlier method of request_firmware would work out as is with
the only disadvantage of the user having to depend on hotplug mechanism
and echoing firmware name.
Let me know if that is acceptable till we find a solution to wait for
ever without using hotplug stuff.

Thanks
Abhay
